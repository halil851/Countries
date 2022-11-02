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
    
    
    var countryNames = [CountryDetails]()
    
    @IBOutlet weak var button: UIButton!
    var passCountryName = ""
    var passCountryCode = ""
    var passWikiDataId = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navBar.title = passCountryName
        getImage()
        countryCode.text = "Country Code: \(passCountryCode)"
        
        isSaved()
    }
    
    func isSaved() {
        if SavedVC.savedCountryName.contains(where: { $0 == navBar.title}){
            savedButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        } else {
            savedButton.setImage(UIImage(systemName: "star"), for: .normal)
        }
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
//        performSegue(withIdentifier: "goToHome", sender: self)
        navigationController?.popToRootViewController(animated: true)

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
    // MARK: - Getting flag images
    
    func getImage () {
        
        let SVGCoder = SDImageSVGCoder.shared
        SDImageCodersManager.shared.addCoder(SVGCoder)
        //let fullNameArr = countryName.split(separator:" ")
        
        if let url = URL(string: "https://wft-geo-db.p.rapidapi.com/v1/geo/countries/\(passCountryCode)?limit=10&rapidapi-key=ee432ced90msh2d96ce8d845cc2cp1a83dajsn5bc61b24a12f") {
            
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { data, response, error in
                if error == nil {
                    let decoder = JSONDecoder()
                    if let safeData = data {
                        do {
                            let results = try decoder.decode(CountryDetails.self, from: safeData)
                            self.setImage(results: results)
                        } catch {
                            print(error)
                        }
                    }
                }
            }
            task.resume()
        }
    }
    
    func setImage (results: CountryDetails) {
        let svgURL = URL(string: results.data.flagImageUri!)
        
        self.flagImage.sd_setImage(with: svgURL) { (image, error, cacheType, url) in
            if image != nil {
                print("Image loaded succesfully")
            }
        }
    }
}

