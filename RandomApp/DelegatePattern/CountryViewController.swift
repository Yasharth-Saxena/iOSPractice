//
//  CountryViewController.swift
//  DelegatePattern
//
//  Created by Yasharth Saxena on 15/05/20.
//  Copyright © 2020 Yasharth Saxena. All rights reserved.
//

import UIKit

protocol CountryDelegate {
    func didUpdateCountry(_ name: String)
}

class CountryViewController: UIViewController {
    
    var countryArray = [CountryModel]()
    var delegate: CountryDelegate?

    @IBOutlet weak var countryTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        countryTableView.dataSource = self
        countryTableView.delegate = self
        
        
        performRequest { (result) in
            switch result {
            case .success(let data):
                self.countryArray = data
                DispatchQueue.main.async {
                    self.countryTableView.reloadData()
                }
            case .failure(let error):
                print("Error populating the table View: \(error)")
            }
        }
        
    }
    
    func performRequest(completion: @escaping (Result<[CountryModel], Error>) -> Void) {
        let baseURL = "https://restcountries.eu/rest/v2/all"
        
        if let urlString = URL(string: baseURL) {
            URLSession.shared.dataTask(with: urlString) { (data, response, error) in
                guard let validData = data, error == nil else {
                    completion(.failure(error!))
                    return
                }
                
                do {
                    let decodedData = try JSONDecoder().decode([CountryModel].self, from: validData)
                    completion(.success(decodedData))
                } catch {
                    completion(.failure(error))
                }
            }.resume()
        }
    }

}

extension CountryViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countryArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath)
        cell.textLabel?.text = countryArray[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        delegate?.didUpdateCountry(countryArray[indexPath.row].name)
        navigationController?.popViewController(animated: true)
    }
}
