//
//  ViewController.swift
//  SomethingWithMVVM
//
//  Created by Yasharth Saxena on 29/06/20.
//  Copyright © 2020 Yasharth Saxena. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var dataArray = [UserModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(CustomTableViewCell.nib(), forCellReuseIdentifier: CustomTableViewCell.identifier)
        
        tableView.dataSource = self
        tableView.delegate = self
        
        ViewModel.shared.getUserDataUsingAF { (result) in
            switch result {
            case .success(let dataArray):
                self.dataArray = dataArray
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print("API Error: \(error)")
            }
        }
    }


}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier, for: indexPath) as! CustomTableViewCell
        let uid = dataArray[indexPath.row].userId
        let id = dataArray[indexPath.row].id
        let title = dataArray[indexPath.row].title
        
        cell.configureUI(userId: uid, id: id, title: title)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}



