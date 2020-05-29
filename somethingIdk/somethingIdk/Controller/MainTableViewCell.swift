//
//  MainTableViewCell.swift
//  somethingIdk
//
//  Created by Yasharth Saxena on 26/05/20.
//  Copyright © 2020 Yasharth Saxena. All rights reserved.
//

import UIKit
import SDWebImage

class MainTableViewCell: UITableViewCell {
    fileprivate let baseURLString = "https://api.themoviedb.org/3/trending/all/day?api_key=820016b7116f872f5f27bf56f9fdfb66"
    static let identifier = "MainTableViewCell"
    var mainImageBaseURL = URL(string: "https://image.tmdb.org/t/p/w300")
    let placeholderImage = UIImage(named: "betaal")
    var trendingMovies = [MainMovieModel]()
    
    @IBOutlet weak var mainCollectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        mainCollectionView.dataSource = self
        mainCollectionView.delegate = self
        mainCollectionView.register(MainCollectionViewCell.nib(), forCellWithReuseIdentifier: MainCollectionViewCell.identifier)
        
        NetworkingClient.shared.performRequest(urlString: baseURLString) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let trendingMovieData):
                self.trendingMovies = trendingMovieData
                DispatchQueue.main.async {
                    self.mainCollectionView.reloadData()
                    // if something happens uncomment the next line maybe?
                    // self.reloadInputViews()
                }
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    static func nib() -> UINib {
        return UINib(nibName: self.identifier, bundle: nil)
    }
    
}

extension MainTableViewCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return trendingMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCollectionViewCell.identifier, for: indexPath) as! MainCollectionViewCell
        let mainImagePath = trendingMovies[indexPath.item].backdropPath
        let mainImageURL = mainImageBaseURL?.appendingPathComponent(mainImagePath)
        
        // setup the image for the cell here
        cell.mainImageView.sd_setImage(with: mainImageURL, placeholderImage: placeholderImage, options: SDWebImageOptions.highPriority) { (mainDownloadedImage, downloadException, cacheType, downloadURL) in
            
            if let downloadException = downloadException {
                print("Error downloading main image: \(downloadException)")
            } else {
                print("Successfully downloaded main image: \(String(describing: downloadURL?.absoluteString))")
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = collectionView.bounds.width - 35 
        let height: CGFloat = width * 0.56
        
        return CGSize(width: width, height: height)
    }
}



