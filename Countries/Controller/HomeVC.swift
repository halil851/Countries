//
//  HomeVC.swift
//  Countries
//
//  Created by halil dikişli on 5.10.2022.
//

import UIKit
import Foundation

class HomeVC:  UITableViewController {
    
    
    var countryList = [Country]()
    var name = Country(code: "", currencyCodes: [""], name: "", wikiDataId: "")
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.reloadData()
        tableView.separatorStyle = .none
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        let anonymousFunction = { (fetchedCountryList: [Country]) in
            self.countryList = fetchedCountryList
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        CountriesAPI.shared.fetchCountriesList(onCompletion: anonymousFunction)
       
    }
    
}
// MARK: - TableView Data Source Methods

extension HomeVC {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countryList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CountriesCell", for: indexPath) as! HomeCell
        
        let name = countryList[indexPath.row]
        cell.configure(model: name)
        
        
        tableView.rowHeight = 70
        
        if SavedVC.savedCountryName.contains(where: { $0 == cell.countryLabel.text}){
            cell.savedButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        } else {
            cell.savedButton.setImage(UIImage(systemName: "star"), for: .normal)
        }
 
        return cell
    }
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
}



// MARK: - TableView Delegate Methods

extension HomeVC {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        name = countryList[indexPath.row]
        print(name.name)
        
        tableView.deselectRow(at: indexPath, animated: true)
        tableView.reloadData()
        
        performSegue(withIdentifier: "goToDetailFromHomeVC", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToDetailFromHomeVC" {
            let destinationVC = segue.destination as! DetailVC
            
            destinationVC.passCountryName = name.name
            destinationVC.passCountryCode = name.code ?? "None"
            destinationVC.passWikiDataId = name.wikiDataId
     
        }
    }
}
