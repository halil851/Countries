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
    @IBOutlet weak var savedButton: UIBarButtonItem!
    
    
    @IBOutlet weak var countryCode: UILabel!
    @IBOutlet weak var flagImage: UIImageView!

    var passCountryName = ""
    var passCountryCode = ""
    var passWikiDataId = ""
    

    
    var countriesAPI = CountriesAPI()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        navBar.title = passCountryName
        getImage(countryName: passCountryName)
        countryCode.text = passCountryCode
        
        
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

        let svgURL = URL(string: "http://commons.wikimedia.org/wiki/Special:FilePath/Flag%20of%20\(fullNameArr[0]).svg" )!
        
        
        
        flagImage.sd_setImage(with: svgURL) { (image, error, cacheType, url) in
            if image != nil {
                print("SVGView SVG load success")
            }
        }
    }
    
    
    
}
