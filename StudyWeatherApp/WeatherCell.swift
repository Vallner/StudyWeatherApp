//
//  WeatherCell.swift
//  StudyWeatherApp
//
//  Created by  on 20.05.25.
//

import UIKit

class WeatherCell: UITableViewCell {
    
    weak var delegate: ViewController?
    
    let dayOfWeek:UILabel = {
        let dayOfWeek = UILabel()
        dayOfWeek.translatesAutoresizingMaskIntoConstraints = false
        dayOfWeek.font = .systemFont(ofSize: 15, weight: .medium)
        dayOfWeek.textColor = .white
        return dayOfWeek
    }()
    
    lazy var icon:UIImageView = {
        let icon = UIImageView()
        icon.translatesAutoresizingMaskIntoConstraints = false
        return icon
    }()
    
    var date:UILabel = {
        let date = UILabel()
        date.translatesAutoresizingMaskIntoConstraints = false
        date.font = .systemFont(ofSize: 10, weight: .medium)
        date.textColor = .white
        return date
    }()
    
    var temperatureLabel: UILabel = {
        let temparature = UILabel()
        temparature.translatesAutoresizingMaskIntoConstraints = false
        temparature.font = .systemFont(ofSize: 15, weight: .medium)
        temparature.textColor = .white
        return temparature
    }()
    
    func setupLayout(){
        backgroundColor = UIColor(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1))
        contentView.addSubview(icon)
        contentView.addSubview(temperatureLabel)
        contentView.addSubview(date)
        contentView.addSubview(dayOfWeek)
        NSLayoutConstraint.activate ([
            dayOfWeek.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 10),
            dayOfWeek.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            icon.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 60),
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
        
        temperatureLabel.text = ("\(day.day.mintempC)" + "° - \(day.day.maxtempC)" + "°" )
        date.text = ("\(day.date)")
        dayOfWeek.text = ("\(getWeekday(from: day.dateEpoch))")
        
    }
    
    func getWeekday(from date: Int) -> String {
        let calendar = Calendar.current
        let today = calendar.component(.weekday, from: Date())
        let components = calendar.component(.weekday, from: Date.init(timeIntervalSince1970: Double(date)))
       
        switch components {
        case today:
            return "Today"
        case 1:
            return "Sun"
        case 2:
            return "Mon"
        case 3:
            return "Tue"
        case 4:
            return "Wed"
        case 5:
            return "Thu"
        case 6:
            return "Fri"
        default :
            return "Sat"
        }
        
    }
    
}
