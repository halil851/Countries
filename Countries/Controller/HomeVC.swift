//
//  HomeVC.swift
//  Countries
//
//  Created by halil dikişli on 5.10.2022.
//

import UIKit
import Foundation
import CoreData

class HomeVC:  UITableViewController {
    
    //var homeCell = HomeCell()
    static let shared = HomeVC()
    
    var countryList = [Country]()
    var name = Country(code: "", currencyCodes: [""], name: "", wikiDataId: "")
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var itemsToCD = [Item]()
    static var saved = [Item]()
    var sendTheIndexPathRow = Int()
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        loadItems()
        
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
        
        
        return countryList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CountriesCell", for: indexPath) as! HomeCell
        
        let name = countryList[indexPath.row]
        cell.countryLabel.text = name.name

        // if itemsToCD already exist // it avoids adding unnecessery new Item
        if itemsToCD.count < countryList.count {
            let newItem = Item(context: context)
            newItem.title = name.name
            newItem.done = false
            itemsToCD.append(newItem)
            HomeVC.saved.append(newItem)
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
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        
//        print(HomeVC.filtered)
        
        tableView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    override func viewDidDisappear(_ animated: Bool) {
       
    }
    override func viewDidLayoutSubviews() {
        
    }
    override func viewWillLayoutSubviews() {
//        print(HomeVC.filtered)
    }
    
    
    func reloadTable(){
        tableView.reloadData()
        print("si")
    }
    
}



// MARK: - TableView Delegate Methods

extension HomeVC {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        name = countryList[indexPath.row]
        print(name.name)
        
        sendTheIndexPathRow = indexPath.row
        print("\(sendTheIndexPathRow) from HomeVC")
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
            destinationVC.getIndexPathRow = sendTheIndexPathRow
        }
    }
    
    // MARK: - CoreData Storage Manager

    func saveItems() {
        do{
            try context.save()
        } catch {
            print("Error saving context (HomeVC) \(error)")
        }

    }

    func loadItems() {
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        do {
            itemsToCD = try context.fetch(request)
            HomeVC.saved = try context.fetch(request)
        } catch {
            print("Error fetching data from context \(error)")
        }
    }
}

