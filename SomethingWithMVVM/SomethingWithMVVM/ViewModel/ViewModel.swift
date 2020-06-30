//
//  ViewModel.swift
//  SomethingWithMVVM
//
//  Created by Yasharth Saxena on 30/06/20.
//  Copyright © 2020 Yasharth Saxena. All rights reserved.
//

import UIKit
import Alamofire

class ViewModel {
    typealias WebServiceHandler = ([[String: Any]]?, Error?) -> Void
    
    // perform networking request with a particular url
    func performRequest(_ url: URL, completion: @escaping WebServiceHandler) {
        Alamofire.request(url).validate().responseJSON { (response) in
            if let error = response.error {
                completion(nil, error)
            } else if let dataArray = response.result.value as? [[String: Any]] {
                completion(dataArray, nil)
            } else if let singleDataDict = response.result.value as? [String: Any] {
                completion([singleDataDict], nil)
            }
        }
    }
    
    
    // set constraints for the mainView's subviews
    func setConstraints(textView: UITextView, button: UIButton, view: UIView) {
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            textView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            textView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            textView.bottomAnchor.constraint(equalTo: button.topAnchor, constant: -5)
        ])
        
        NSLayoutConstraint.activate([
            button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.widthAnchor.constraint(greaterThanOrEqualToConstant: 100)
        ])
    }
}
