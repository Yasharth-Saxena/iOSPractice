//
//  TrendingTableViewCell.swift
//  somethingIdk
//
//  Created by Yasharth Saxena on 27/05/20.
//  Copyright © 2020 Yasharth Saxena. All rights reserved.
//

import UIKit
import SDWebImage

class TrendingTableViewCell: UITableViewCell {
    fileprivate let mainBaseURL = "https://api.themoviedb.org/3/trending/all/day?api_key=820016b7116f872f5f27bf56f9fdfb66"
    static let identifier = "TrendingTableViewCell"
    fileprivate var trendingImageBaseURL = URL(string: "https://image.tmdb.org/t/p/w154")
    fileprivate let placeholderImage = UIImage(named: "someImage")
    var trendingMovieArray = [MainMovieModel]()

    @IBOutlet weak var trendingCollectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        trendingCollectionView.dataSource = self
        trendingCollectionView.delegate = self
        
        trendingCollectionView.register(TrendingCollectionViewCell.nib(), forCellWithReuseIdentifier: TrendingCollectionViewCell.identifier)
        NetworkingClient.shared.performRequest(urlString: mainBaseURL) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let trendingMovieData):
                self.trendingMovieArray = trendingMovieData
                DispatchQueue.main.async {
                    self.trendingCollectionView.reloadData()
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

extension TrendingTableViewCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return trendingMovieArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TrendingCollectionViewCell.identifier, for: indexPath) as! TrendingCollectionViewCell
        let trendingImagePath = trendingMovieArray[indexPath.item].imagePath
        let trendingImageURL = trendingImageBaseURL?.appendingPathComponent(trendingImagePath)
        cell.trendingImageView.sd_setImage(with: trendingImageURL, placeholderImage: placeholderImage, options: SDWebImageOptions.highPriority) { (downloadedTrendingImage, downloadException, cacheType, trendingImageDownloadURL) in
            if let downloadException = downloadException {
                print("Error downloading trending image: \(downloadException)")
            } else {
                print("Successfully downloaded trending image: \(String(describing: trendingImageDownloadURL?.absoluteString))")
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

