//
//  ViewController.swift
//  StudyWeatherApp
//
//  Created by Danila Savitsky on 17.05.25.
//

import UIKit

class ViewController: UIViewController {
    
    var netManager: NetManager = NetManager(with: .default)
    
    var weather:Weather?
    
    var refresh = UIRefreshControl()
    
    let headerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBlue
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return view
    }()
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
    
    lazy var tableView:UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 80
        tableView.layer.cornerRadius = 10
        tableView.register(WeatherCell.self, forCellReuseIdentifier: "WeatherCell")
        tableView.backgroundColor = UIColor(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1))
        return tableView
        
    }()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        loadForecast(for: "Minsk")
        setupLayout()

    }
    
    func loadForecast(for city: String) {
        Task{
            do{
                weather = try await  netManager.obtainData(for: city)
                
                imageView.image = try await UIImage(data : netManager.getImage(urlString: "https:" + weather!.current.condition.icon))
                
                temperatureLabel.text = "\(weather!.current.tempC)" + "°"
                
                dateOfRequest.text = weather!.location.localtime
                
                cityLabel.text = weather!.location.name
                
                descriptionLabel.text = weather!.current.condition.text
                
                windLabel.text = "\(weather!.current.windKph) km/h"
                
                humidityLabel.text = "\(weather!.current.humidity)%"
                
                tableView.reloadData()
 
            } catch {
                print("Error: \(error)")
            }
        }
    }

    func setupLayout() {
        let stackView = UIStackView(arrangedSubviews: [imageView, descriptionLabel])
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        tableView.addSubview(refresh)
        refresh.addTarget(self, action: #selector(refreshData), for: UIControl.Event.valueChanged)
        
        
        view.backgroundColor = .systemBlue
        headerView.addSubview(stackView)
        headerView.addSubview(dateOfRequest)
        headerView.addSubview(cityLabel)
        headerView.addSubview(temperatureLabel)
        headerView.addSubview(windLabel)
        headerView.addSubview(humidityLabel)
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            
            cityLabel.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 30),
            cityLabel.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            cityLabel.bottomAnchor.constraint(equalTo: dateOfRequest.topAnchor),
            
            dateOfRequest.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            dateOfRequest.bottomAnchor.constraint(equalTo: temperatureLabel.topAnchor, constant: -20),
            
            temperatureLabel.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            temperatureLabel.bottomAnchor.constraint(equalTo: stackView.topAnchor,constant: -20),
            
            stackView.centerXAnchor.constraint(equalTo: headerView.centerXAnchor, constant: -15),
            stackView.bottomAnchor.constraint(equalTo: windLabel.topAnchor),
            
            windLabel.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            windLabel.bottomAnchor.constraint(equalTo: humidityLabel.topAnchor),
            
            humidityLabel.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            humidityLabel.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -20),

            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
            
        ])
    }
    
    @objc func refreshData(send:UIRefreshControl) {

        loadForecast(for: "Minsk")
        setupLayout()
        tableView.reloadData()
        send.endRefreshing()
    }
    
}

extension ViewController:UITableViewDataSource,UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        weather?.forecast.forecastday.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherCell", for: indexPath) as! WeatherCell
            cell.delegate = self
            cell.configureCell(with: weather!.forecast.forecastday[indexPath.row])
            if indexPath.row == 0{
                cell.dayOfWeek.text = "Today"
            }
            cell.setupLayout()
            return cell
        }
        
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    
        tableView.sectionHeaderTopPadding = 0
        let sectionView = headerView
        sectionView.layer.shadowRadius = 10
        sectionView.layer.shadowOpacity = 0.5
        
        return sectionView
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailed = DetailedViewController()
        detailed.delegate = self
        detailed.configureView(with: weather!.forecast.forecastday[indexPath.row])
        present(detailed, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
