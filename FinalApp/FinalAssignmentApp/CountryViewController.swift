//
//  CountryViewController.swift
//  FinalAssignmentApp
//
//  Created by Yasharth Saxena on 13/05/20.
//  Copyright © 2020 Yasharth Saxena. All rights reserved.
//

import UIKit

class CountryViewController: UIViewController {
    
    let appManager = AppManager()
    var countryArray = [CountryModel]()

    @IBOutlet weak var countryTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        countryTableView.dataSource = self
        countryTableView.delegate = self

        appManager.performRequest { [weak self] (result) in
            switch result {
            case .success(let data):
                self?.countryArray = data
                DispatchQueue.main.async {
                    self?.countryTableView.reloadData()
                }
            case .failure(let error):
                print("Error fetching data: \(error)")
            }
        }
    }
}

extension CountryViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countryArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "countryTableCell", for: indexPath)
        cell.textLabel?.text = countryArray[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.dismiss(animated: true, completion: nil)
    }
}
