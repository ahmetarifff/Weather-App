//
//  weatherModel.swift
//  Clima
//
//  Created by Ahmet arif Yıldırım on 15.04.2023.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import Foundation

struct WeatherModel {
    
    var weatherId : Int
    let city : String
    let temperature : Double
    
    var temperatureString : String {
        
        
        return String(format: "%.1f", temperature)
        
        
        
    }

    var conditionName : String
    {
        
        
        switch weatherId {
        case 200...531:
            
            return "cloud.rain"
        case 600...622:
           return "snow"
        case 800 :
            return"sun.max"
        case 801...804:
            return "cloud"
            
        default:
            return "cloud"
            
        }
        
        
        
    }
    
    
    
    
}


