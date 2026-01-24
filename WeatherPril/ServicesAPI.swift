//
//  ServicesAPI.swift
//  WeatherPril
//
//  Created by Alina Spitsina on 10.11.2025.
//

import Foundation

protocol WeatherServiceProtocol {
    func fetchWeather (for city: String, completion: @escaping (Result<WeatherModel, Error>) -> Void)
}

final class WeatherService: WeatherServiceProtocol {
    
    private let apiKey = "2bbe843c310c360f25c851f06787239a"
    
    func fetchWeather(for city: String, completion: @escaping (Result<WeatherModel, Error>) -> Void) {
        let cityRequest = city.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? city
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(cityRequest)&appid=\(apiKey)&units=metric&lang=ru")
        else { return }
        
        URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else { return }
            do {
                let weather = try JSONDecoder().decode(WeatherModel.self, from: data)
                completion(.success(weather))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}


