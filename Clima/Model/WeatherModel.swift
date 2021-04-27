//
//  File.swift
//  Clima
//
//  Created by lunarian on 01/06/2020.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation

struct WeatherModel{
    let conditionID : Int
    let cityName : String
    let temp : Double
    var tempString : String {
        return String(format: "%.1f", temp)
    }
    
    var conditionName : String {
        
        switch conditionID {
        case 200...232:
            return "cloud.bot"
            
        case 300...321:
            return "clout.drizzle"
            
        case 500...531:
            return "cloud.rain"
            
        case 600...622:
            return "snow"
            
        case 701...781:
            return "cloud.fog"
            
        case 800:
            return  "sun.max"
            
        case 801...804:
            return"cloud"
            
        default:
            return"cloud"
        }
        
        
    }
    
    
    
}
