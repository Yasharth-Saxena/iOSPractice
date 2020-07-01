//
//  ViewController.swift
//  ImageRequest
//
//  Created by Yasharth Saxena on 01/07/20.
//  Copyright © 2020 Yasharth Saxena. All rights reserved.
//

import UIKit

enum KittenImageLocation: String {
    case http = "http://www.kittenswhiskers.com/wp-content/uploads/sites/23/2014/02/Kitten-playing-with-yarn.jpg"
    case https = "https://upload.wikimedia.org/wikipedia/commons/thumb/0/06/Kitten_in_Rizal_Park%2C_Manila.jpg/460px-Kitten_in_Rizal_Park%2C_Manila.jpg"
    case error = "not a url"
}

class ViewController: UIViewController {
    let imageLocation = KittenImageLocation.https.rawValue
    
    @IBOutlet weak var imageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
     
        
    }

    @IBAction func handleLoadImageButtonPressed(_ sender: UIButton) {
        // using the URLSessionDataTask
//        guard let imageURL = URL(string: imageLocation) else {
//            print("Cannot create URL")
//            return
//        }
//
//        let task = URLSession.shared.dataTask(with: imageURL) { (data, response, error) in
//            guard let data = data else {
//                print("Couldn't fetch data or maybe there was an error!")
//                return
//            }
//
//            let downloadedImage = UIImage(data: data)
//            print("ImageDownloadedSuccessfully")
//            DispatchQueue.main.async {
//                self.imageView.image = downloadedImage
//            }
//        }
//        task.resume()
        
        // using the URLSessionDownloadTask
        guard let imageURL = URL(string: imageLocation) else {
            print("Can't create URL")
            return
        }
        
        let task = URLSession.shared.downloadTask(with: imageURL) { (location, response, error) in
            // this is the location of a temporary file where the data received from the server is stored, not storing it somewhere else deletes the data and it's lost
            guard let location = location else {
                print("Location is nil!")
                return
            }
            
            do {
                let imageData = try Data(contentsOf: location)
                let downloadedImage = UIImage(data: imageData)
                DispatchQueue.main.async {
                    self.imageView.image = downloadedImage
                }
            } catch {
                print("Couldn't fetch image data: \(error)")
            }
            
        }
        
        task.resume()
    }

}

