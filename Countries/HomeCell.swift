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
    
    
    
    override func awakeFromNib() {

        super.awakeFromNib()
        countryView.layer.borderWidth = 1.5
        countryView.layer.cornerRadius = 10
        
        //loadItems()
        
        
    }
    
    
    
    @IBAction func savedButtonPressed(_ sender: Any) {
        
        isSaved = !isSaved
        if isSaved {
            savedButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
            
        } else {
            savedButton.setImage(UIImage(systemName: "star"), for: .normal)
           
           // savedButton.setImage(UIImage(named: "star.png"), for: .normal)
            
        }
        
    }
    
//    func loadItems () {
//        if let data = try? Data(contentsOf: dataFilePath!){
//            let decoder = PropertyListDecoder()
//            do {
//                savedItem = try decoder.decode([Item].self, from: data)
//            } catch {
//                print("error decoding savedItem")
//            }
//
//        }
//    }
    
    
}
