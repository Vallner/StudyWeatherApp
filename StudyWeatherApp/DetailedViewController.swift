//
//  DetailedViewController.swift
//  StudyWeatherApp
//
//  Created by  on 21.05.25.
//

import UIKit

class DetailedViewController: UIViewController {

    weak var delegate:ViewController?
    
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
        view.backgroundColor = UIColor(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1))
        super.viewDidLoad()
        setupLayout()
        
        // Do any additional setup after loading the view.
    }
    func configureView(with day: Forecastday ){
        
        Task{
            do{
                imageView.image = try await UIImage(data: (delegate!.netManager.getImage(urlString: "https:" + day.day.condition.icon)))
            } catch {
                print(error)
            }
            temperatureLabel.text = "\(day.day.avgtempC)" + "°"
            
            dateOfRequest.text = day.date
            
            cityLabel.text = delegate?.weather?.location.name
            
            descriptionLabel.text = day.day.condition.text
            
            windLabel.text = "\(day.day.avgvisKM) km/h"
            
            humidityLabel.text = "\(day.day.avghumidity)%"
            
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
            
            cityLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 30),
            cityLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cityLabel.bottomAnchor.constraint(equalTo: dateOfRequest.topAnchor),
            dateOfRequest.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            dateOfRequest.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            dateOfRequest.bottomAnchor.constraint(equalTo: temperatureLabel.topAnchor, constant: -20),
            
            temperatureLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            temperatureLabel.bottomAnchor.constraint(equalTo: stackView.topAnchor,constant: -20),
            
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -15),
            stackView.bottomAnchor.constraint(equalTo: windLabel.topAnchor),
            
            windLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            windLabel.bottomAnchor.constraint(equalTo: humidityLabel.topAnchor),
            
            humidityLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            humidityLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            
        ])
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
