//
//  WeatherData.swift
//  Clima
//
//  Created by lunarian on 01/06/2020.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation

import Foundation

struct WeatherData: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Codable {
    let temp: Double
}

struct Weather: Codable {
    let description: String
    let id: Int
}
