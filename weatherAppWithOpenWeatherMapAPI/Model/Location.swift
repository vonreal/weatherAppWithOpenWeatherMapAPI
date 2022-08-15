//
//  Location.swift
//  weatherAppWithOpenWeatherMapAPI
//
//  Created by 나지운 on 2022/08/15.
//

import CoreLocation
import Foundation

struct Location {
    var latitude = 37.517829
    var longitude = 126.886270
    
    var currentLatitude: Double {
        get {
            return self.latitude
        }
        
        set {
            self.latitude = newValue
        }
    }
    
    var currentLongitude: Double {
        get {
            return self.longitude
        }
        
        set {
            self.longitude = newValue
        }
    }
    
    func getCityName(getCity: @escaping (String) -> ()) {
        let location = CLLocation(latitude: self.latitude, longitude: self.longitude)
        let geocoder = CLGeocoder()
        let locale = Locale(identifier: "Ko-kr")
        geocoder.reverseGeocodeLocation(location, preferredLocale: locale) { [self]placemarks, _ in
            guard let placemarks = placemarks?.first,
                  let dong = placemarks.subLocality,
                  let city = placemarks.locality
            else { return }
            getCity("\(city), \(dong)")
        }
    }
}
