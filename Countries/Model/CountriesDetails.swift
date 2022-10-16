//
//  CountriesDetails.swift
//  Countries
//
//  Created by halil dikişli on 16.10.2022.
//

import Foundation

struct CountryDetails : Codable {
    let data : CountryDetail
}

struct CountryDetail : Codable {
    let code : String?
    let flagImageUri : String?
    let name : String?
    let wikiDataId : String?
}
