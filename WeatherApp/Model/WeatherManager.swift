//
//  WeatherManager.swift
//  WeatherApp
//
//  Created by SLV on 21.07.2024.
//

import Foundation

struct WeatherManager{
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=94b93413b57b6694e8497a7930c62b23&units=metric"

 
   // MARK: - Fetch city to URL
    func fetchWeather (cityName: String)  {
        let urlString = "\(weatherURL)&q=\(cityName)"
        print(urlString)
        performRequest(urlString: urlString)
    }
    
    


    
    //MARK: - Perfom request
    func performRequest(urlString: String){
        
        // 1. Create a URL
        if let url = URL(string: urlString) {
            
            // 2. Create a URL Session
            let session = URLSession(configuration: .default)
            
            // 3. Give the session a task
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil{
                    print(error!)
                    return 
                }
                if let safeData = data {
                    parseJSON(weatherData: safeData)
                } 
            }
            // 4. Start the task
            task.resume()
        }
    }

    //MARK: - - Parse JSON
    func parseJSON(weatherData: Data) {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherDataModel.self, from: weatherData)
            print(decodedData.weather)
        } catch {
            print(error)
        }
    }
}
