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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        savedView.layer.borderWidth = 1.5
        savedView.layer.cornerRadius = 10
        
    }
    
}
