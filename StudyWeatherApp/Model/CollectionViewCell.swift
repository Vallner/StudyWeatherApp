//
//  CollectionViewCell.swift
//  StudyWeatherApp
//
//  Created by Danila Savitsky on 22.05.25.
//

import UIKit

class HourCollectionViewCell: UICollectionViewCell {
    
    lazy  var image: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var temperatureLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var weatherDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.textColor = .white
        label.numberOfLines = 2
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func configure(with hour: Hour ) {
        backgroundColor = UIColor(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1))
        temperatureLabel.text = ("\(hour.tempC)" + "°")
        weatherDescriptionLabel.text = ("\(hour.condition.text)")
        timeLabel.text = ("\(hour.time.dropFirst(11))")
    }
    
    func setupLayout() {
        
        contentView.addSubview(image)
        contentView.addSubview(timeLabel)
        contentView.addSubview(temperatureLabel)
        contentView.addSubview(weatherDescriptionLabel)
        
        NSLayoutConstraint.activate([
            
            timeLabel.topAnchor.constraint(equalTo:  contentView.topAnchor, constant: 8),
            timeLabel.leadingAnchor.constraint(equalTo:  contentView.leadingAnchor),
            timeLabel.trailingAnchor.constraint(equalTo:  contentView.trailingAnchor),
            
            image.topAnchor.constraint(equalTo:  timeLabel.bottomAnchor),
            image.leadingAnchor.constraint(equalTo:  contentView.leadingAnchor),
            image.trailingAnchor.constraint(equalTo:  contentView.trailingAnchor),
            
            temperatureLabel.topAnchor.constraint(equalTo: image.bottomAnchor),
            temperatureLabel.leadingAnchor.constraint(equalTo:  contentView.leadingAnchor),
            temperatureLabel.trailingAnchor.constraint(equalTo:  contentView.trailingAnchor),
            
            weatherDescriptionLabel.topAnchor.constraint(equalTo: temperatureLabel.bottomAnchor, constant: 4),
            weatherDescriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            weatherDescriptionLabel.trailingAnchor.constraint(equalTo:   contentView.trailingAnchor)
            ])}
    }

