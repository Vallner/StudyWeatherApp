//
//  ViewController.swift
//  StudyWeatherApp
//
//  Created by Danila Savitsky on 17.05.25.
//

import UIKit

class ViewController: UIViewController {
    
    var netManager: NetManager = NetManager(with: .default)
    
    lazy var cityLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 30, weight: .medium)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var dateOfRequest: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 10, weight: .light)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var temperatureLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 50, weight: .light)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var humidityLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 15, weight: .light)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var windLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 15, weight: .light)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 20, weight: .light)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        returnTemperature()
        setupLayout()
    }
    override func viewDidAppear(_ animated: Bool) {
        returnTemperature()
    }
    func returnTemperature() {
        Task{
            do{
                let weather = try await  netManager.obtainData()
                
                imageView.image = try await UIImage(data : netManager.getImage(urlString: "https:" + weather.current.condition.icon))
                
                temperatureLabel.text = "\(weather.current.tempC)"
                
                dateOfRequest.text = weather.location.localtime
                
                cityLabel.text = weather.location.name
                
                descriptionLabel.text = weather.current.condition.text
                
                windLabel.text = "\(weather.current.windKph) km/h"
                
                humidityLabel.text = "\(weather.current.humidity)%"
 
            } catch {
                print("Error: \(error)")
            }
        }
    }

    func setupLayout() {
        let stackView = UIStackView(arrangedSubviews: [imageView, descriptionLabel])
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.backgroundColor = .systemBlue
        view.addSubview(stackView)
        view.addSubview(dateOfRequest)
        view.addSubview(cityLabel)
        view.addSubview(temperatureLabel)
        view.addSubview(windLabel)
        view.addSubview(humidityLabel)
        NSLayoutConstraint.activate([
            cityLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 250),
            cityLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cityLabel.bottomAnchor.constraint(equalTo: dateOfRequest.topAnchor),
            
            dateOfRequest.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            dateOfRequest.bottomAnchor.constraint(equalTo: temperatureLabel.topAnchor, constant: -20),
            
            temperatureLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            temperatureLabel.bottomAnchor.constraint(equalTo: stackView.topAnchor,constant: 20),
            
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -15),
            stackView.bottomAnchor.constraint(equalTo: windLabel.topAnchor),
            
            windLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            windLabel.bottomAnchor.constraint(equalTo: humidityLabel.topAnchor),
            
            humidityLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            
            
        ])
    }
}

