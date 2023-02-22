//
//  HomeVC.swift
//  Countries
//
//  Created by halil dikişli on 5.10.2022.
//
import UIKit
import Foundation
import CoreData

var itemsToCD = [Item]()
    
class HomeVC:  UITableViewController {
    
    static let shared = HomeVC()
    static var countryList = [Country]()
    var name = Country(code: "", currencyCodes: [""], name: "", wikiDataId: "")
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var itemsToCD1 = [Item]()
    var sendTheIndexPathRow = Int()
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Change status bar colour
     /*   let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = UIColor.red
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance */
       
        loadItems()
        tableView.reloadData()
        tableView.separatorStyle = .none
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        //Adding countries to countryList
        let anonymousFunction = { (fetchedCountryList: [Country]) in
            HomeVC.countryList = fetchedCountryList
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
            
        }
        
        CountriesAPI.shared.fetchCountriesList(onCompletion: anonymousFunction)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        tableView.reloadData()
    }
    
    
    
    
    
    // MARK: - Save button pressed
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        let buttonPosition = sender.convert(CGPoint.zero, to: self.tableView)
        let indxPath = tableView.indexPathForRow(at: buttonPosition)
        
        if itemsToCD[indxPath!.row].done {
            sender.setImage(UIImage(systemName: "star"), for: .normal)
        } else {
            sender.setImage(UIImage(systemName: "star.fill"), for: .normal)
        }
        
        itemsToCD[indxPath!.row].done = !itemsToCD[indxPath!.row].done
        saveItems()
    }
}


// MARK: - TableView Data Source Methods

extension HomeVC {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return HomeVC.countryList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CountriesCell", for: indexPath) as! HomeCell
        
        let country = HomeVC.countryList[indexPath.row]
        cell.countryLabel.text = country.name

        // if itemsToCD already exist, it avoids adding unnecessery new Item
        // it only works when you run the app very first time
      
        if itemsToCD.count < HomeVC.countryList.count {
            let newItem = Item(context: context)
            newItem.title = country.name
            newItem.done = false
            itemsToCD.append(newItem)
            print(newItem)
            
        }
        
        
        
        // Check if Countries from API has been changed. If so, update to Core Data.
        if country.name != itemsToCD[indexPath.row].title {
           updateItems(indexPath: indexPath, country: country)
        }
        
        
        if itemsToCD[indexPath.row].done {
            cell.saveButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        } else {
            cell.saveButton.setImage(UIImage(systemName: "star"), for: .normal)
        }
      
        saveItems()
        tableView.rowHeight = 70
        return cell
    }
    
}


// MARK: - TableView Delegate Methods

extension HomeVC {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        name = HomeVC.countryList[indexPath.row]
        
        sendTheIndexPathRow = indexPath.row
        tableView.deselectRow(at: indexPath, animated: true)
        tableView.reloadData()
        
        performSegue(withIdentifier: "goToDetailFromHomeVC", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToDetailFromHomeVC" {
            let destinationVC = segue.destination as! DetailVC
            
            destinationVC.passCountryName = name.name
            destinationVC.passCountryCode = name.code 
            destinationVC.passWikiDataId = name.wikiDataId
            destinationVC.getIndexPathRow = sendTheIndexPathRow
//            destinationVC.itemsToCD = itemsToCD
        }
    }
}


// MARK: - CoreData Storage Manager
extension HomeVC {
    func saveItems() {
        do {
            try context.save()
        } catch {
            print("Error saving context (HomeVC) \(error)")
        }
    }

    func loadItems() {
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        do {
            itemsToCD = try context.fetch(request)
        } catch {
            print("Error fetching data from context \(error)")
        }
    }
    
    func updateItems(indexPath: IndexPath, country: Country ) {
        print("Data from API has been changed. New Country: \(country.name) has been updated.")
        itemsToCD[indexPath.row].title = country.name
        itemsToCD[indexPath.row].done = false
    }
}

