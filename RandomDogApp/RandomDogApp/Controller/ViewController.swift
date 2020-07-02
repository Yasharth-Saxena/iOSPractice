//
//  ViewController.swift
//  RandomDogApp
//
//  Created by Yasharth Saxena on 02/07/20.
//  Copyright © 2020 Yasharth Saxena. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    
    let randomImageEndpoint = DogViewModel.Endpoint.randomImageFromDogCollection.url

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // gets a jsonObject from the server (["message": "<contains imageURL>", "status": "<contains success status>"]) converts it to a DogImage and passes the control over to self.handleRandomImageResponse(model:error:)
        DogViewModel.requestRandomImage(with: randomImageEndpoint, completionHandler: handleRandomImageResponse(model:error:))
    }
    
    func handleRandomImageResponse(model: DogImage?, error: Error?) {
        // stores the randomDogImageURL from the instance of the DogImage struct and passes control over to self.handleImageFileResponse(image:error:)
        if let imageURL = URL(string: model?.message ?? "nothing") {
            DogViewModel.requestImageFile(with: imageURL, completionHandler: handleImageFileResponse(image:error:))
        }
    }
    
    func handleImageFileResponse(image: UIImage?, error: Error?) {
        // if there's an error the image is set to nil 
        DispatchQueue.main.async {
            self.imageView.image = image
        }
    }
    

}

