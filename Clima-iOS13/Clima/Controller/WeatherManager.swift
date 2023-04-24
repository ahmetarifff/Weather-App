
import Foundation
import UIKit
import CoreLocation

protocol WeatherManageDelegate {
    
    
    func didUpdateWeather(_ weatherManager:  WeatherManager, weather: WeatherModel)
}

    
struct WeatherManager{
        
        let weatherUrl = "https://api.openweathermap.org/data/2.5/weather?&appid=3ccd7760e8e3d80d12105e099b926219&units=metric"
        var  delegate : WeatherManageDelegate?
    
        func weatherCityName(cityname:String){
            
            let urlString = "\(weatherUrl)&q=\(cityname)"
            
            
            performRequest(urlString: urlString)
            
        }
    
    func weatherCityName(lon:CLLocationDegrees,lat:CLLocationDegrees){
        let urlString1 = "\(weatherUrl)&lon=\(lon)&lat=\(lat)"
        performRequest(urlString: urlString1)
    }
        
        
        func performRequest(urlString : String){
            if let url = URL(string: urlString){
                let session = URLSession(configuration: .default)
                let task = session.dataTask(with: url) { data, response, error in
                    if error != nil {
                        print(error!)
                        return
                    }
                    if let safeData = data {
                        
                        if let weather = self.parseJSON(safeData)
                        {
                            self.delegate?.didUpdateWeather(self, weather: weather)

                        }
                       
                    }
                }
                task.resume()
            }
        }
        
    func parseJSON(_ weatherData:Data) -> WeatherModel? {
            let decoder = JSONDecoder()
            do{
                let decodedData =  try decoder.decode(WeatherData.self, from: weatherData)
    
                let id = decodedData.weather[0].id
                let temp = decodedData.main.temp
                let name = decodedData.name
                let weather = WeatherModel(weatherId:id, city: name, temperature: temp)
                
                return weather
                
                
            }
            catch{
                print(error)
            }
            
            return nil
            
            
        }
        
        
        
       
        
        
        
    }
    

    
