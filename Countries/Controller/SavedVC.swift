//
//  SavedVC.swift
//  Countries
//
//  Created by halil dikişli on 5.10.2022.
//

import UIKit
import Foundation

class SavedVC:  UITableViewController {
    
    
    static var savedCountryName = UserDefaults.standard.object(forKey: "savedCountryName") as? [String] ?? [String]()
    static var savedCountryCode = UserDefaults.standard.object(forKey: "savedCountryCode") as? [String] ?? [String]()
    
    var countryList = [Country]()
    var name = Country(code: "", currencyCodes: [""], name: "", wikiDataId: "")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
           
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SavedVC.savedCountryName.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SavedCell", for: indexPath) as! SavedCell
        
        let countryName = SavedVC.savedCountryName[indexPath.row]
        let countryCode = SavedVC.savedCountryCode[indexPath.row]
        cell.configure(name: countryName, code: countryCode)
        
        
        tableView.rowHeight = 70
        if SavedVC.savedCountryName.contains(where: { $0 == cell.savedLabel.text}){
            cell.savedButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        }else {
            cell.savedButton.setImage(UIImage(systemName: "star"), for: .normal)
        }
        
        return cell
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        tableView.reloadData()
    }
}




