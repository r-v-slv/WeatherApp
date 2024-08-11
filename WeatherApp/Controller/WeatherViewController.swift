//
//  SceneDelegate.swift
//  WeatherApp
//
//  Created by SLV on 09.07.2024.
//

import UIKit
import AVFoundation
import CoreLocation

class WeatherViewController: UIViewController, UITextFieldDelegate, WeatherManagerDelegate {

    

    
    //MARK: - IBOutlets
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!

    //MARK: - Properties
    var weatherManager = WeatherManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        weatherManager.delegate = self
        searchTextField.delegate = self

    }

    @IBAction func searchPressed(_ sender: UIButton) {
        searchTextField.endEditing(true)

    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)

        return true
    }
    

    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != ""{
            textField.placeholder="Search"
            return true
        }else{
            textField.placeholder="Please privide a city to get weather"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        
        if let city = searchTextField.text {
            weatherManager.fetchWeather(cityName: city)
        } else { return }

        
        searchTextField.text = ""
    }
    
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
            DispatchQueue.main.async {
                self.temperatureLabel.text = weather.temperatureString
                self.conditionImageView.image = UIImage(systemName: weather.conditionName)
                self.cityLabel.text = weather.cityName
            }
        }
    
        func didFailWithError(error: Error) {
            print(error)
        }
    
}
//
//
////MARK: - WeatherManagerDelegate
//extension WeatherViewController: WeatherManagerDelegate {
//    
//    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
//        DispatchQueue.main.async {
//            self.temperatureLabel.text = weather.temperatureString
//            self.conditionImageView.image = UIImage(systemName: weather.conditionName)
//            self.cityLabel.text = weather.cityName
//        }
//    }
//    
//    func didFailWithError(error: Error) {
//        print(error)
//    }
//}
//
////MARK: - CLLocationManagerDelegate
//extension WeatherViewController: CLLocationManagerDelegate {
//    
//    @IBAction func locationPressed(_ sender: UIButton) {
//        locationManager.requestLocation()
//    }
//    
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        if let location = locations.last {
//            locationManager.stopUpdatingLocation()
//            let lat = location.coordinate.latitude
//            let lon = location.coordinate.longitude
//            weatherManager.fetchWeather(latitude: lat, longitude: lon)
//        }
//    }
//    
//    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
//        print(error)
//    }
//}
