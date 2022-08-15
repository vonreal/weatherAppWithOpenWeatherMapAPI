//
//  WeatherViewController.swift
//  weatherAppWithOpenWeatherMapAPI
//
//  Created by 나지운 on 2022/08/15.
//

import UIKit

class WeatherViewController: UIViewController {
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var currentTempLabel: UILabel!
    
    @IBOutlet var bubbleCollectionView: [UIView]!
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var currentTimeLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var windLabel: UILabel!
    
    let location = Location()
    var weather = Weather()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        WeatherAPIManager.shared.requestWeather(location: location) { weather in
            self.weather = weather
            
            self.designView()
        }
    }
    
    func designView() {
        backgroundView.setGradient(color1: DefaultColor.dawn, color2: DefaultColor.afternoon)
        
        Location().getCityName { city in
            self.locationLabel.text = city
        }        
        locationLabel.textColor = .white
        locationLabel.font = DefaultFont.locationFont
        
        weatherImageView.image = UIImage(named: weather.icon)
        
        currentTempLabel.text = String(format: "%.1f", weather.currentTemp) + "°"
        currentTempLabel.textColor = .white
        currentTempLabel.font = DefaultFont.tempFont
        
        currentTimeLabel.text = "현재 습도는 \(weather.humidity)%입니다."
        currentTimeLabel.font = DefaultFont.bubbleFont
        
        descriptionLabel.text = "현재 \(weather.description) 상태입니다."
        descriptionLabel.font = DefaultFont.bubbleFont
        
        windLabel.text = "현재 풍속은 \(weather.windSpeed)m/s입니다."
        windLabel.font = DefaultFont.bubbleFont
        
        for view in bubbleCollectionView {
            view.layer.cornerRadius = 5
        }
    }
}

extension UIView{
    func setGradient(color1: UIColor,color2: UIColor) {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.colors = [color1.cgColor,color2.cgColor]
        gradient.locations = [0.0 , 1.0]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradient.endPoint = CGPoint(x: 0.0, y: 1.0)
        gradient.frame = bounds
        layer.addSublayer(gradient)
    }
}

