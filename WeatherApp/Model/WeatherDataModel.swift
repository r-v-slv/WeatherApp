//
//  WeatherDataModel.swift
//  WeatherApp
//
//  Created by SLV on 22.07.2024.
//

import Foundation

//MARK: - General data
struct WeatherDataModel: Decodable {
    let name: String
    let main: Main
    let weather: [Weather]
    
}


//MARK: - Main section
struct Main: Decodable{
    let temp: Double
}


//MARK: - Description section
struct Weather: Decodable{
    let id: Int
    let description: String
}

