//
//  ViewController.swift
//  WeatherPril
//
//  Created by Alina Spitsina on 10.11.2025.
//

import UIKit

final class WeatherViewController: UIViewController {
      
    // MARK: - Presenter
    
    private var presenter: WeatherPresenterProtocol!
    
    // MARK: - UI
    
    private let cityText: UITextField = {
        let cityText = UITextField()
        cityText.placeholder = "Введите название города"
        cityText.borderStyle = .roundedRect
        cityText.translatesAutoresizingMaskIntoConstraints = false
        return cityText
    }()
    
    private let weatherButton: UIButton = {
        let weatherButton = UIButton(type: .system)
        weatherButton.translatesAutoresizingMaskIntoConstraints = false
        weatherButton.setImage(UIImage(named: "iconSearch"), for: .normal)
        weatherButton.tintColor = .white
        return weatherButton
    }()
    
    private let temperatureLabel: UILabel = {
        let tempLabel = UILabel()
        tempLabel.font = UIFont.systemFont(ofSize: 60, weight: .medium)
        tempLabel.translatesAutoresizingMaskIntoConstraints = false
        tempLabel.textColor = .white
        return tempLabel
    }()
    
    private let temperatureMaxLabel: UILabel = {
        let tempMaxLabel = UILabel()
        tempMaxLabel.font = UIFont.systemFont(ofSize: 30, weight: .medium)
        tempMaxLabel.translatesAutoresizingMaskIntoConstraints = false
        tempMaxLabel.textColor = .white
        return tempMaxLabel
    }()
    
    private let temperatureMinLabel: UILabel = {
        let tempMinLabel = UILabel()
        tempMinLabel.font = UIFont.systemFont(ofSize: 30, weight: .medium)
        tempMinLabel.translatesAutoresizingMaskIntoConstraints = false
        tempMinLabel.textColor = .white
        return tempMinLabel
    }()
    
    // MARK: - LifeCicle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .darkViolet
        title = "Погода"
        print("Kal")
                
        presenter = WeatherPresenter(view: self)
        
        setupUI()
        weatherButton.addTarget(self, action: #selector(getWeatherTapped), for: .touchUpInside)
    }
    
    private func setupUI() {
        view.addSubview(cityText)
        view.addSubview(weatherButton)
        view.addSubview(temperatureLabel)
        view.addSubview(temperatureMaxLabel)
        view.addSubview(temperatureMinLabel)
        
        NSLayoutConstraint.activate([
            cityText.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            cityText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            cityText.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            weatherButton.widthAnchor.constraint(equalToConstant: 44),
            weatherButton.heightAnchor.constraint(equalToConstant: 44),
            weatherButton.topAnchor.constraint(equalTo: cityText.bottomAnchor, constant: 40),
            weatherButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            temperatureLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            temperatureLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            temperatureMaxLabel.topAnchor.constraint(equalTo: temperatureLabel.bottomAnchor, constant: 20),
            temperatureMaxLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            
            temperatureMinLabel.topAnchor.constraint(equalTo: temperatureLabel.bottomAnchor, constant: 20),
            temperatureMinLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40)
        ])
    }
    
    @objc private func getWeatherTapped() {
        guard let city = cityText.text, !city.isEmpty else {
            showError("Введите название города")
            return
        }
        presenter.getWeather(for: city)
    }
}

extension WeatherViewController: WeatherViewProtocol {
    func showWeather(city: String, temperature: String, tempMax: String, tempMin: String) {
        temperatureLabel.text = "\(temperature)"
        temperatureMaxLabel.text = "max: \(tempMax)"
        temperatureMinLabel.text = "min: \(tempMin)"
    }
    func showError(_ message: String) {
        let alert = UIAlertController(title: "Ошибка", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel))
        present(alert, animated: true)
    }
}


