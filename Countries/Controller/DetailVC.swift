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

    
    var countriesAPI = CountriesAPI()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        navBar.title = passCountryName
        getImage(countryName: passCountryName)
        countryCode.text = "Country Code: \(passCountryCode)"
        
        
    }
    
    func getImage (countryName: String) {
        let SVGCoder = SDImageSVGCoder.shared
        SDImageCodersManager.shared.addCoder(SVGCoder)
        

        let svgURL = URL(string: "http://commons.wikimedia.org/wiki/Special:FilePath/Flag%20of%20\(countryName).svg" )!
        
        flagImage.sd_setImage(with: svgURL) { (image, error, cacheType, url) in
            if image != nil {
                print("SVGView SVG load success")
            }
        }
    }
    
    
    
}
