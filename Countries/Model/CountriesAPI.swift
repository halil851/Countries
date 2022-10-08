//
//  CountriesAPI.swift
//  Countries
//
//  Created by halil dikişli on 5.10.2022.
//

import Foundation

final class CountriesAPI: ObservableObject {
    
    static let shared = CountriesAPI()
    @Published var posts = [Country]()
    
    func fetchCountriesList(onCompletion: @escaping ([Country]) -> () ) {
        
        //let api = "ee432ced90msh2d96ce8d845cc2cp1a83dajsn5bc61b24a12f"
        let URLString = "https://wft-geo-db.p.rapidapi.com/v1/geo/countries?rapidapi-key=ee432ced90msh2d96ce8d845cc2cp1a83dajsn5bc61b24a12f&limit=10"
        
        if let url = URL(string: URLString){
            let task = URLSession.shared.dataTask(with: url) { (data, resp, error) in
                guard let data = data else {
                    print("data is nil")
                    return
                }
                guard let countryList = try? JSONDecoder().decode(CountriesData.self, from: data) else {
                    print("couldn't decode JSON")
                    return
                }
                self.posts = countryList.data
                //print(countryList.data)
                onCompletion(countryList.data)
            }
            task.resume()
        }
        
        
        
    }
}


//func fetchCountriesList(onCompletion: @escaping ([Country]) -> () ) {
//
//    //let api = "ee432ced90msh2d96ce8d845cc2cp1a83dajsn5bc61b24a12f"
//    let URLString = "https://wft-geo-db.p.rapidapi.com/v1/geo/countries?rapidapi-key=ee432ced90msh2d96ce8d845cc2cp1a83dajsn5bc61b24a12f&limit=10"
//    let url = URL(string: URLString)!
//
//    let task = URLSession.shared.dataTask(with: url) { (data, resp, error) in
//        guard let data = data else {
//            print("data is nil")
//            return
//        }
//        guard let countryList = try? JSONDecoder().decode(CountriesData.self, from: data) else {
//            print("couldn't decode JSON")
//            return
//        }
//        self.posts = countryList.data
//        //print(countryList.data)
//        onCompletion(countryList.data)
//    }
//    task.resume()
//}
