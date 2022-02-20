//
//  NetworkManager.swift
//  G-Weather
//
//  Created by Сперанский Никита on 20.02.2022.
//

import Foundation

struct NetworkManager {

    func fetchWeather(latitude: Double, longitude: Double, complitionHendler: @escaping (Weather) -> Void) {
        
        let urlString = "https://api.weather.yandex.ru/v2/forecast?lat=\(latitude)&lon=\(longitude)"
        guard let url = URL(string: urlString) else { return }
        
        var request = URLRequest(url: url, timeoutInterval: Double.infinity)
        request.addValue("\(apiKey)", forHTTPHeaderField: "X-Yandex-API-Key")
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { (data, responce, error) in
            guard let data = data else {
                print(String(describing: error))
                return
            }
//            print(String(data: data, encoding: .utf8)!)
            if let weather = self.parseJSON(with: data) {
                complitionHendler(weather)
            }
        }
        task.resume()
    }
    
    
    func parseJSON(with data: Data) -> Weather? {
        let decder = JSONDecoder()
        
        do {
            let weatherData = try decder.decode(WeatherData.self, from: data)
            guard let weather = Weather(weatherData: weatherData) else {
                return nil
            }
            return weather
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        return nil
    }
    
    
    
    
}
