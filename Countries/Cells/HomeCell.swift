//
//  HomeCell.swift
//  Countries
//
//  Created by halil dikişli on 5.10.2022.
//
import UIKit


class HomeCell: UITableViewCell, UINavigationControllerDelegate {
    
    //var favButtonPressed : (() -> ()) = {}
    
    var countryModel: Country?
    static let shared = HomeCell()
    
    
    
    @IBOutlet weak var savedButton: UIButton!
    @IBOutlet weak var countryView: UIView!
    @IBOutlet weak var countryLabel: UILabel!
    
    var code = ""
    
    var savedItem = [Country]()
    
    
    
    override func awakeFromNib() {

        super.awakeFromNib()
        countryView.layer.borderWidth = 1.5
        countryView.layer.cornerRadius = 10
        
    }
    
    func configure(model: Country) {
        self.countryLabel.text = model.name
        self.code = model.code ?? ""
    }
    
    
    @IBAction func savedButtonPressed(_ sender: Any) {
        
        if savedButton.currentImage == UIImage(systemName: "star"){
            SavedVC.savedCountryName.append(countryLabel.text ?? "")
            SavedVC.savedCountryCode.append(code)
            savedButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        } else {
            SavedVC.savedCountryName.removeAll(where: {$0 == countryLabel.text})
            SavedVC.savedCountryCode.removeAll(where: {$0 == code})
            savedButton.setImage(UIImage(systemName: "star"), for: .normal)
        }
        UserDefaults.standard.set(SavedVC.savedCountryName, forKey: "saved")
        UserDefaults.standard.set(SavedVC.savedCountryCode, forKey: "savedCode")
        UserDefaults.standard.synchronize()
        
        
    }
    
    
 
}
