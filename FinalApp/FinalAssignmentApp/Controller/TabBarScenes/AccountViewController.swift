//
//  ViewController.swift
//  FinalAssignmentApp
//
//  Created by Yasharth Saxena on 13/05/20.
//  Copyright © 2020 Yasharth Saxena. All rights reserved.
//

import UIKit

class AccountViewController: UIViewController {
    
    let appManager = AppManager()

    @IBOutlet weak var accountTableView: UITableView!
    @IBOutlet weak var userImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // this function registers the custom nib files for the accountTableView
        AppModel.shared.registerNibs(for: accountTableView)
        AppModel.shared.roundImage(userImage)
        accountTableView.rowHeight = 60
    }

    @IBAction func signInTapped(_ sender: Any) {
        // TODO: Make a Login Screen
    }
    
    @IBAction func joinTapped(_ sender: Any) {
        // TODO: Make a SignUp Screen
    }
    

}


extension AccountViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return AppModel.shared.section1Array.count
        case 1:
            return AppModel.shared.section2Array.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "normalCell", for: indexPath) as! NormalCell
            cell.mainImageView.image = AppModel.shared.section1Array[indexPath.row].image
            cell.mainTitle.text = AppModel.shared.section1Array[indexPath.row].title
            return cell
        case 1:
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "countryCell", for: indexPath) as! CountryCell
                cell.mainImageView.image = AppModel.shared.section2Array[indexPath.row].image
                cell.mainTitle.text = AppModel.shared.section2Array[indexPath.row].title
                return cell
            } else if indexPath.row == 1 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "languageCell", for: indexPath) as! LanguageCell
                cell.mainImageView.image = AppModel.shared.section2Array[indexPath.row].image
                cell.mainTitle.text = AppModel.shared.section2Array[indexPath.row].title
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "normalCell", for: indexPath) as! NormalCell
                cell.mainImageView.image = AppModel.shared.section2Array[indexPath.row].image
                cell.mainTitle.text = AppModel.shared.section2Array[indexPath.row].title
                return cell 
            }
            
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.section {
        case 0:
            break
        case 1:
            if indexPath.row == 0 {
                let countryVC = storyboard?.instantiateViewController(withIdentifier: "CountryView") as! CountryViewController
                self.present(countryVC, animated: true, completion: nil)
            } else if indexPath.row == 1 {
                // TODO: Languages list screen setup here
            }
        default:
            print("Error populating the country list")
        }
    }
    
}






