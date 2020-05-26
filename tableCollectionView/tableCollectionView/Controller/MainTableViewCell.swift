//
//  MainTableViewCell.swift
//  tableCollectionView
//
//  Created by Yasharth Saxena on 26/05/20.
//  Copyright © 2020 Yasharth Saxena. All rights reserved.
//

import UIKit
import SDWebImage

class MainTableViewCell: UITableViewCell {
    var trendingMovies = [MovieModel]()
    var mainImageBaseURL = URL(string: "https://image.tmdb.org/t/p/w300")
    let placeholderImage = UIImage(named: "mainImage")
    
    @IBOutlet weak var mainCollectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        mainCollectionView.dataSource = self
        mainCollectionView.delegate = self
        
        NetworkingClient.shared.getTrendingMovies { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let trendingMovieData):
                self.trendingMovies = trendingMovieData
                DispatchQueue.main.async {
                    self.mainCollectionView.reloadData()
                }
            case .failure(let error):
                print("Error while using the API: \(error)")
            }
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

}

extension MainTableViewCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return trendingMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mainCollectionCell", for: indexPath) as! MainCollectionViewCell
        // setup image for the collection view using SDWebImage
        let imagePath = trendingMovies[indexPath.item].backdropPath
        let mainImageURL = self.mainImageBaseURL?.appendingPathComponent(imagePath)
        cell.mainImageView?.sd_setHighlightedImage(with: mainImageURL, options: SDWebImageOptions.highPriority, progress: nil, completed: { (downloadedImage, downloadException, cacheType, downloadURL) in
            if let downloadException = downloadException {
                print("Error downloading mainImage: \(downloadException)")
            } else {
                print("Successfully downloaded main image: \(String(describing: downloadURL?.absoluteString))")
            }
        })
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = collectionView.bounds.width
        let height: CGFloat = 0.56 * width
        return CGSize(width: width, height: height)
    }

}
