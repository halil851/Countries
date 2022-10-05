//
//  HomeCell.swift
//  Countries
//
//  Created by halil dikişli on 5.10.2022.
//
import UIKit


class HomeCell: UITableViewCell, UINavigationControllerDelegate {
    
    
    
    @IBOutlet weak var countryView: UIView!
    @IBOutlet weak var countryLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        countryView.layer.borderWidth = 1
//        countryView.layer.cornerRadius = 5
        
        
        
    }
}
