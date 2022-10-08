//
//  DetailVC.swift
//  Countries
//
//  Created by halil dikişli on 6.10.2022.
//

import UIKit
import SDWebImageSVGCoder


class DetailVC : UIViewController {
    
    @IBOutlet weak var navBar: UINavigationItem!
    
    @IBOutlet weak var savedButton: UIButton!
    @IBOutlet weak var countryCode: UILabel!
    @IBOutlet weak var flagImage: UIImageView!
    
    var passCountryName = ""
    var passCountryCode = ""
    var passWikiDataId = ""
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        navBar.title = passCountryName
        getImage(countryName: passCountryName)
        countryCode.text = passCountryCode
        
        isSaved()
    }
    
    func isSaved() {
        if SavedVC.savedCountryName.contains(where: { $0 == navBar.title}){
            savedButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        }else {
            savedButton.setImage(UIImage(systemName: "star"), for: .normal)
        }
    }

    @IBAction func savedButtonTap(_ sender: UIButton) {
        if savedButton.currentImage == UIImage(systemName: "star"){
            
            SavedVC.savedCountryName.append(navBar.title ?? "")
            SavedVC.savedCountryCode.append(countryCode.text ?? "")
            savedButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
            
        } else if savedButton.currentImage == UIImage(systemName: "star.fill") {
            
            SavedVC.savedCountryName.removeAll(where: {$0 == navBar.title})
            SavedVC.savedCountryCode.removeAll(where: {$0 == countryCode.text})
            savedButton.setImage(UIImage(systemName: "star"), for: .normal)
        }
        UserDefaults.standard.set(SavedVC.savedCountryName, forKey: "savedCountryName")
        UserDefaults.standard.set(SavedVC.savedCountryCode, forKey: "savedCountryCode")
        UserDefaults.standard.synchronize()
    }
    
    
    @IBAction func infoButton(_ sender: UIButton) {
        if let url = URL(string: "https://www.wikidata.org/wiki/\(passWikiDataId)") {
            UIApplication.shared.open(url)
        }
    }
    
    func getImage (countryName: String) {
        
        let SVGCoder = SDImageSVGCoder.shared
        SDImageCodersManager.shared.addCoder(SVGCoder)
        let fullNameArr = countryName.split(separator:" ")
        let svgURL = URL(string: "http://commons.wikimedia.org/wiki/Special:FilePath/Flag%20of%20\(fullNameArr[0]).svg")!

        flagImage.sd_setImage(with: svgURL) { (image, error, cacheType, url) in
            if image != nil {
                print("Image loaded succesfully")
            }
        }
    }
}
