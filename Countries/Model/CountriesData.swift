//
//  CountriesData.swift
//  Countries
//
//  Created by halil dikişli on 4.10.2022.
//

import Foundation

struct CountriesData: Decodable {
    let data: [Country]    
}

struct Country: Decodable {
    let code: String
    let currencyCodes: [String]
    let name: String
    let wikiDataId: String

}



