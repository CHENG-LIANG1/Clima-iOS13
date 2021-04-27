//
//  WeatherManager.swift
//  Clima
//
//  Created by lunarian on 01/06/2020.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation
import CoreLocation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}


struct WeatherManager{
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=96f35cb1fbb587e19930675e944e2ec3&units=metric"
    
    var delegate: WeatherManagerDelegate?
    

    mutating func fetchWeather(_ cityName: String){
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(urlString)
    }
    
    mutating func fetchWeather(_ lat: CLLocationDegrees, _ lon: CLLocationDegrees){
        let urlString = "\(weatherURL)&lat=\(lat)&lon=\(lon)"
        performRequest(urlString)
    }
    
    func performRequest(_ urlString: String){
        // 1. Create a URL
        // 2. Create a URL Session
        // 3. Give the session a task
        // 4. Start the task
        
        if let url = URL(string: urlString){
            
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil{
                    delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data{
                    if let weather = self.parseJSON(weatherData: safeData){
                        self.delegate?.didUpdateWeather(self, weather: weather)
                    }
                }
            }
            
            task.resume()
        }
        
    }
    
    func parseJSON(weatherData: Data) -> WeatherModel?{
        let decoder = JSONDecoder()
        do{
           let decodedData =  try decoder.decode(WeatherData.self, from: weatherData)
            
            let id = decodedData.weather[0].id
            let temperature = decodedData.main.temp
            let cityName = decodedData.name
            let weatherModel = WeatherModel(conditionID: id, cityName: cityName, temp: temperature)
            
            return weatherModel
        
        }catch{
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
    
}
