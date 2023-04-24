//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//
import Foundation
import UIKit
import CoreLocation

class WeatherViewController: UIViewController,CLLocationManagerDelegate{
    
   
   

    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    
    
    @IBOutlet weak var searcTextField: UITextField!
    var weatherManager = WeatherManager()
    var locationManager = CLLocationManager()
    
    
    override func viewDidLoad() {
        
        self.background.image = UIImage(named: "yagmur.pdf")
       
       
        weatherManager.delegate = self
        super.viewDidLoad()
        searcTextField.delegate = self
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
   

        
        
    }
    
    
    @IBAction func getLocation(_ sender: UIButton) {
        locationManager.requestLocation()
        
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let lon = location.coordinate.longitude
            let lat = location.coordinate.latitude
            weatherManager.weatherCityName(lon: lon, lat: lat)
        }
    
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    

}
    
    
   
















extension WeatherViewController:WeatherManageDelegate{
    
    func didUpdateWeather(_ weatherManager:  WeatherManager, weather: WeatherModel)
    {
        DispatchQueue.main.async {
            self.temperatureLabel.text =  weather.temperatureString
            self.conditionImageView.image = UIImage(systemName: weather.conditionName)
            self.cityLabel.text = weather.city
            if (weather.weatherId >= 200 && weather.weatherId <= 531) {
                
                self.background.image = UIImage(named: "yagmur.pdf")
                
            }
            
            else if   (weather.weatherId >= 801 && weather.weatherId <= 804) {
                self.background.image = UIImage(named: "bulutluhava.pdf")
                
            }
            
            else if   (weather.weatherId == 800) {
                self.background.image = UIImage(named: "guneslihava.pdf")
                
            }
            else if   (weather.weatherId >= 600 && weather.weatherId <= 622) {
                self.background.image = UIImage(named: "karlıhava.pdf")
                
            }
            
            
            
            
            
                
           
           
                
            
        
        }
            
        }
    
    func didFailWithError(error:Error){
        
        print(error)
    }
    
   
    
    
    
    
}

extension WeatherViewController:UITextFieldDelegate {
    
    @IBAction func searchButton(_ sender: UIButton) {
        
      
        searcTextField.endEditing(true)
        print(searcTextField.text!)
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searcTextField.endEditing(true)
        print(searcTextField.text!)
        
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        
        if textField.text != "" {
            return true
        }
        else
        {
            textField.placeholder = "do not empty"
            return false
        }
        
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let city = searcTextField.text{
            weatherManager.weatherCityName(cityname: city)
            
        }
        searcTextField.text = ""
    }
    
    
    
    
    
}
