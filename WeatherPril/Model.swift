//
//  Model.swift
//  WeatherPril
//
//  Created by Alina Spitsina on 10.11.2025.
//

import Foundation

struct WeatherModel: Codable {
    let name: String
    let main: Main
}

struct Main: Codable {
    let temp: Double
    let temp_max: Double
    let temp_min: Double
}



