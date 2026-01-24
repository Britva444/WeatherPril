//
//  Presenter.swift
//  WeatherPril
//
//  Created by Alina Spitsina on 10.11.2025.
//
import Foundation

protocol WeatherViewProtocol: AnyObject {
    func showWeather(city: String, temperature: String, tempMax: String, tempMin: String)
    func showError(_ message: String)
}

protocol WeatherPresenterProtocol {
    func getWeather(for city: String)
}
final class WeatherPresenter: WeatherPresenterProtocol {
    private weak var view: WeatherViewProtocol?
    private let service: WeatherServiceProtocol
    
    init(view: WeatherViewProtocol, service: WeatherServiceProtocol = WeatherService()) {
        self.view = view
        self.service = service
        print("KOK")
    }
    
    func getWeather(for city: String) {
        service.fetchWeather(for: city) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let weather):
                    let tempValue = weather.main.temp
                    let safeTemp = tempValue.isNaN ? 0 : tempValue
                    
                    let tempMaxValue = weather.main.temp_max
                    let safeTempMax = tempMaxValue.isNaN ? 0 : tempMaxValue
                    
                    let tempMinValue = weather.main.temp_min
                    let safeTempMin = tempMinValue.isNaN ? 0 : tempMinValue
                    
                    let temp = String(format: "%.1f C", safeTemp)
                    let tempMax = String(format: "%.1f C", safeTempMax)
                    let tempMin = String(format: "%.1f C", safeTempMin)
                    
                    self?.view?.showWeather(city: weather.name, temperature: temp, tempMax: tempMax, tempMin: tempMin)
                case .failure:
                    self?.view?.showError("Не получилось получить данные. Проверьте название города")
                }
            }
        }
    }
}

