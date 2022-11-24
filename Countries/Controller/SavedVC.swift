//
//  SavedVC.swift
//  Countries
//
//  Created by halil dikişli on 5.10.2022.
//

import UIKit
import Foundation
import CoreData

class SavedVC:  UITableViewController {
    
    static var savedCountryName = UserDefaults.standard.object(forKey: "savedCountryName") as? [String] ?? [String]()
    static var savedCountryCode = UserDefaults.standard.object(forKey: "savedCountryCode") as? [String] ?? [String]()
    
    static let shared = SavedVC()
    var savedCountries = [CountrySavedManager]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.separatorStyle = .none
        refreshData()
        getSavedCountries()
        
    }
    override func viewDidAppear(_ animated: Bool) {
        refreshData()
    }
    
    
    func getSavedCountries () {
        for i in HomeVC.shared.itemsToCD {
            if i.done  {
                let countryData = CountrySavedManager(done: i.done, title: i.title!)
                savedCountries.append(countryData)
            }
        }
    }
    
    func refreshData(){
        savedCountries.removeAll()
        getSavedCountries()
        tableView.reloadData()
        
    }
    
    
   
// MARK: - UNSAVED - REMOVE THE ITEM FROM SAVE COUNTRY PAGE AND ALSO COREDATA
    @IBAction func savedButtonTapped(_ sender: UIButton) {
        
        // TO GET THE INDEXPATH
        let buttonPosition = sender.convert(CGPoint.zero, to: self.tableView)
        let indxPath = tableView.indexPathForRow(at: buttonPosition)
        
        // FIND THE DATA IN COREDATA
        let filterThis = savedCountries[indxPath!.row].title
        let match = NSFetchRequest<Item>(entityName: "Item")
        match.predicate = NSPredicate(format: "title == %@", filterThis)
        
        do {
            let result = try HomeVC.shared.context.fetch(match)
            result[0].done = false     // MAKE THE FOUNDED DATA'S DONE PROPERTY FALSE
            print("\(String(describing: result[0].title)) is unsaved from Saved Countries Page")
            savedCountries.remove(at: indxPath!.row)   // REMOVE THE UNSAVED COUNTRY FROM SAVED COUNTRY PAGE
            
        } catch {
            print("Error fetching data from Saved Countries context \(error)")
        }

        tableView.reloadData()
        
        // SAVE ALL CHANGES
        HomeVC.shared.saveItems()
    }
    
    
    
    
    // MARK: - TABLEVIEW DATA SOURCE
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  savedCountries.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
  
        let cell = tableView.dequeueReusableCell(withIdentifier: "SavedCell", for: indexPath) as! SavedCell
        
        cell.savedButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
  
        let countryName = savedCountries[indexPath.row].title
        let countryCode = "121"  //SavedVC.savedCountryCode[indexPath.row]
        cell.savedLabel.text = countryName
        
  
        tableView.rowHeight = 70
        return cell
    }
    
    
}




