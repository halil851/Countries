//
//  ViewController.swift
//  Countries
//
//  Created by halil dikişli on 4.10.2022.
//

import UIKit
import Foundation

class ViewController: UIViewController {
    
    var countriesManager = CountriesManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        countriesManager.performRequest()
        
        
    }
}

