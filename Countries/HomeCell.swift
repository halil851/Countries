//
//  HomeCell.swift
//  Countries
//
//  Created by halil dikişli on 5.10.2022.
//
import UIKit


class HomeCell: UITableViewCell, UINavigationControllerDelegate {
    
    
    static let shared = HomeCell()
    
    @IBOutlet weak var savedButton: UIButton!
    @IBOutlet weak var countryView: UIView!
    @IBOutlet weak var countryLabel: UILabel!
    
    var isSaved : Bool = false
    var savedItem = [Item]()
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        countryView.layer.borderWidth = 1.5
        countryView.layer.cornerRadius = 10
        
        loadItems()
        
        
    }
    
    
    
    @IBAction func savedButtonPressed(_ sender: Any) {
        
        isSaved = !isSaved
        if isSaved {
            savedButton.setImage(UIImage(named: "star.fill.png"), for: .normal)
            
            let newItem = Item()
            newItem.title = countryLabel.text!
            savedItem.append(newItem)
            let encoder = PropertyListEncoder()
            do {
                 let data = try encoder.encode(savedItem)
                try data.write(to: dataFilePath!)
            } catch {
                print("Error encoding item array")
            }
            
            print(savedItem)
            
            
            
        } else {
            savedButton.setImage(UIImage(named: "star.png"), for: .normal)
            
        }
        
    }
    
    func loadItems () {
        if let data = try? Data(contentsOf: dataFilePath!){
            let decoder = PropertyListDecoder()
            do {
                savedItem = try decoder.decode([Item].self, from: data)
            } catch {
                print("error decoding savedItem")
            }
            
        }
    }
    
}
