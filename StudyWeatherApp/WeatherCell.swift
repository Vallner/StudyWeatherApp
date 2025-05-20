//
//  WeatherCell.swift
//  StudyWeatherApp
//
//  Created by  on 20.05.25.
//

import UIKit

class WeatherCell: UITableViewCell {
    
    weak var delegate: ViewController?
    
    lazy var icon:UIImageView = {
        let icon = UIImageView()
        icon.translatesAutoresizingMaskIntoConstraints = false
        return icon
    }()
    
    var date:UILabel = {
        let date = UILabel()
        date.translatesAutoresizingMaskIntoConstraints = false
        date.font = .systemFont(ofSize: 10, weight: .medium)
        return date
    }()
    
    var temperatureLabel: UILabel = {
        let temparature = UILabel()
        temparature.translatesAutoresizingMaskIntoConstraints = false
        temparature.font = .systemFont(ofSize: 20, weight: .medium)
        return temparature
    }()
    
    func setupLayout(){
        contentView.addSubview(icon)
        contentView.addSubview(temperatureLabel)
        contentView.addSubview(date)
        self.backgroundColor = .clear
        NSLayoutConstraint.activate ([
            icon.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 10),
            icon.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            temperatureLabel.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: 10),
            temperatureLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            
            date.topAnchor.constraint(equalTo: temperatureLabel.bottomAnchor, constant: 5),
            date.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            date.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: 10)
            
        ])
    }
    
    func configureCell(with day: Forecastday){
        Task{
            do{
                icon.image = try await UIImage(data: (delegate!.netManager.getImage(urlString: "https:" + day.day.condition.icon)))
            } catch {
                print(error)
            }
            
        }
        
        temperatureLabel.text = ("\(day.day.avgtempC)")
        date.text = ("\(day.date)")
    }
    
}
