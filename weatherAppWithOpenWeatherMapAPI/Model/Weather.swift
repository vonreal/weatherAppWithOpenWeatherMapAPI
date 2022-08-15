//
//  Weather.swift
//  weatherAppWithOpenWeatherMapAPI
//
//  Created by 나지운 on 2022/08/15.
//

import Foundation

struct Weather {
    var icon: String = ""
    var main: String = ""
    var description: String = ""
    var windSpeed: Double = 0
    var temp: Double = 0
    var humidity: Int = 0
    
    var currentTemp: Double {
            return self.temp - 273.15
    }
}
