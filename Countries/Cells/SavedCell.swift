//
//  SavedCell.swift
//  Countries
//
//  Created by halil dikişli on 6.10.2022.
//

import UIKit


class SavedCell: UITableViewCell, UINavigationControllerDelegate {
    
    @IBOutlet weak var savedButton: UIButton!
    @IBOutlet weak var savedLabel: UILabel!
    @IBOutlet weak var savedView: UIView!
    
    var countryModel: Country?
    var code = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        savedView.layer.borderWidth = 1.5
        savedView.layer.cornerRadius = 10
        
    }
    
    func configure(name: String, code: String) {
        self.savedLabel.text = name
        self.code = code
    }
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        
        if savedButton.currentImage == UIImage(systemName: "star"){
            
            SavedVC.savedCountryName.append(savedLabel.text ?? "")
            SavedVC.savedCountryCode.append(code)
            savedButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
            
        } else if savedButton.currentImage == UIImage(systemName: "star.fill") {
            
            SavedVC.savedCountryName.removeAll(where: {$0 == savedLabel.text})
            SavedVC.savedCountryCode.removeAll(where: {$0 == code})
            savedButton.setImage(UIImage(systemName: "star"), for: .normal)
        }
        UserDefaults.standard.set(SavedVC.savedCountryName, forKey: "savedCountryName")
        UserDefaults.standard.set(SavedVC.savedCountryCode, forKey: "savedCountryCode")
        UserDefaults.standard.synchronize()
    }
    
}


