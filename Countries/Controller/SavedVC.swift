//
//  SavedVC.swift
//  Countries
//
//  Created by halil dikişli on 5.10.2022.
//

import UIKit
import Foundation

class SavedVC:  UITableViewController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return HomeCell.shared.savedItem.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SavedCell", for: indexPath) as! SavedCell
        tableView.rowHeight = 70
        cell.savedLabel.text = HomeCell.shared.savedItem[indexPath.row].title
        print("cellForRowAt")
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.tableView.scrollToRow(at: indexPath, at: .top, animated: true )
        }
        
        return cell
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        tableView.reloadData()
    }
}

