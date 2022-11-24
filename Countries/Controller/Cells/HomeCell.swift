//
//  HomeCell.swift
//  Countries
//
//  Created by halil dikişli on 5.10.2022.
//
import UIKit
import CoreData


class HomeCell: UITableViewCell, UINavigationControllerDelegate {
    
    @IBOutlet weak var saveButton: UIButton!
    
    @IBOutlet weak var countryView: UIView!
    @IBOutlet weak var countryLabel: UILabel!
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        
        HomeVC.shared.loadItems()
        countryView.layer.borderWidth = 1.5
        countryView.layer.cornerRadius = 10
//        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)) // locate the CoreData files. not in Documents file go back once, Library/Application Support

    }
    
}
