//
//  HomeCell.swift
//  Countries
//
//  Created by halil dikişli on 5.10.2022.
//
import UIKit


class HomeCell: UITableViewCell, UINavigationControllerDelegate {
    
    
    @IBOutlet weak var savedButton: UIButton!
    
  
    
    @IBOutlet weak var countryView: UIView!
    @IBOutlet weak var countryLabel: UILabel!
    
    var isSaved : Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        countryView.layer.borderWidth = 1
        countryView.layer.cornerRadius = 8
        
        
        
        
    }
    
    
    
    @IBAction func savedButtonPressed(_ sender: Any) {
        print("savedButtonPressed")
        
        
        isSaved = !isSaved
            if isSaved {
                savedButton.setImage(UIImage(named: "star.fill.png"), for: .normal)
            } else {
                savedButton.setImage(UIImage(named: "star.png"), for: .normal)
            }
        
//        let image = UIImage(named: "star.png")
//        let imageFilled = UIImage(named: "star.fill.png")
//        savedButton.setImage(image, for: .normal)
//        savedButton.setImage(imageFilled, for: .selected)
//
//        savedButton.setImage(imageFilled, for: .selected)
        
        
        //savedButton.setImage(UIImage(named: "star.fill.png"), for: .normal)
//
//        let starImage = UIImage(named: "star.fill.png")
//        let starFillImage = UIImage(named: "star.png")
//
//        if savedButton.setImage == "star.fill.png" {
//
//        }
//        savedButton.setImage(starImage, for: .normal)
     
        
        
        
    }
    
}
