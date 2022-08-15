//
//  WeatherAPIManger.swift
//  weatherAppWithOpenWeatherMapAPI
//
//  Created by 나지운 on 2022/08/15.
//

import Foundation

import Alamofire
import SwiftyJSON

class WeatherAPIManager {
    private init() {}
    
    static let shared = WeatherAPIManager()
    
    func requestWeather(location: Location, saveWeather: @escaping (Weather) -> ()) {
        let url = EndPoint.openWeather + "?lat=\(location.latitude)&lon=\(location.longitude)&lang=kr&appid=\(APIKey.openWeather)"
        
        var weather = Weather()
        AF.request(url, method: .get).validate().responseData { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                for json in json["weather"].arrayValue {
                    weather.icon = json["icon"].stringValue
                    weather.main = json["main"].stringValue
                    weather.description = json["description"].stringValue
                }
                
                weather.windSpeed = json["wind"]["speed"].doubleValue
                weather.temp = json["main"]["temp"].doubleValue
                weather.humidity = json["main"]["humidity"].intValue
                
                saveWeather(weather)
                
            case .failure(let error):
                print(error)
            }
        }
    }
}
