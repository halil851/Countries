//
//  CountriesManager.swift
//  Countries
//
//  Created by halil dikişli on 4.10.2022.
//

import Foundation

struct CountriesManager {
    let api = "ee432ced90msh2d96ce8d845cc2cp1a83dajsn5bc61b24a12f"
    let countiesURL = "https://wft-geo-db.p.rapidapi.com/v1/geo/countries?rapidapi-key=ee432ced90msh2d96ce8d845cc2cp1a83dajsn5bc61b24a12f&limit=10"
    
    
    func performRequest() {
        if let url = URL(string: countiesURL) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }
                if let safeData = data {
                    self.parseJSON(countriesData: safeData)
                    
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(countriesData: Data){
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(CountriesData.self, from: countriesData)
            //print(decodedData.data[1].currencyCodes[0])
            
        } catch {
            print(error)
        }
    }
    
    
}
