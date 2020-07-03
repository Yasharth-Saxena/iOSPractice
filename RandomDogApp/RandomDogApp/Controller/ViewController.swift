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
    @IBOutlet weak var pickerView: UIPickerView!
    
    var breeds = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.dataSource = self
        pickerView.delegate = self
        
        // gets a list of breeds and updates the breeds array in this class 
        DogViewModel.requestBreedsList(completionHandler: handleBreedsListResponse(breeds:error:))
        
    }
    
    func handleRandomImageDataResponse(model: DogImage?, error: Error?) {
        // this method then receives a DogImage instance, having a message and a status property, the message property is an array of strings(urls)
        // it converts a random element of the array to a URL and calls the requestRandomImageFile method, finally passing control to the handleRandomImageResponse(image:error:)
        if let imageURL = URL(string: model?.message.randomElement() ?? "nothing") {
            DogViewModel.requestRandomImageFile(with: imageURL, completionHandler: handleRandomImageFileResponse(image:error:))
        }
    }
    
    func handleRandomImageFileResponse(image: UIImage?, error: Error?) {
        // if there's an error the image is set to nil otherwise a random dog image in accordance with the breed that the user selected 
        DispatchQueue.main.async {
            self.imageView.image = image
        }
    }
    
    func handleBreedsListResponse(breeds: [String], error: Error?) {
        self.breeds = breeds
        DispatchQueue.main.async {
            self.pickerView.reloadAllComponents()
        }
    }
    
}

extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return breeds.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return breeds[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // this requests randomImageData with a specific breed that the user selects and then passes control to the handleRandomImageDataResponse(model:error) method
        DogViewModel.requestRandomImageData(breed: breeds[row], completionHandler: handleRandomImageDataResponse(model:error:))
    }
}
