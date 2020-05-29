//
//  PopularTableViewCell.swift
//  somethingIdk
//
//  Created by Yasharth Saxena on 27/05/20.
//  Copyright © 2020 Yasharth Saxena. All rights reserved.
//

import UIKit
import SDWebImage

class PopularTableViewCell: UITableViewCell {
    static let identifier = "PopularTableViewCell"
    
    fileprivate var popularImageBaseURL = URL(string: "https://image.tmdb.org/t/p/w154")
    fileprivate let placeholderImage = UIImage(named: "someImage") 
    var popularMovieArray = [MainMovieModel]()

    @IBOutlet weak var popularCollectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        popularCollectionView.dataSource = self
        popularCollectionView.delegate = self
        
        popularCollectionView.register(PopularCollectionViewCell.nib(), forCellWithReuseIdentifier: PopularCollectionViewCell.identifier)
        // comment out the next few lines later 
        NetworkingClient.shared.getPopularMovies { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let popularMovieData):
                self.popularMovieArray = popularMovieData
                print("somethingJustLIkeThis: \(self.popularMovieArray)")
                DispatchQueue.main.async {
                    self.popularCollectionView.reloadData()
                }
            case .failure(let error):
                print("Error getting popular data: \(error)")
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

extension PopularTableViewCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return popularMovieArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PopularCollectionViewCell.identifier, for: indexPath) as! PopularCollectionViewCell
        let popularImagePath = popularMovieArray[indexPath.item].imagePath
        print("Count: \(popularMovieArray[indexPath.item].name)")
        let popularImageURL = popularImageBaseURL?.appendingPathComponent(popularImagePath)
        cell.popularImageView.sd_setImage(with: popularImageURL, placeholderImage: placeholderImage, options: SDWebImageOptions.highPriority, progress: nil) { (downloadedPopularImage, downloadException, cacheType, popularImageDownloadURL) in
            if let downloadException = downloadException {
                print("Error downloading popular image: \(downloadException)")
            } else {
                print("Successfully downloaded popular image: \(String(describing: popularImageDownloadURL?.absoluteString))")
            }
        }
        return cell 
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = 154
        let height: CGFloat = 240
        
        return CGSize(width: width, height: height)
    }
}
