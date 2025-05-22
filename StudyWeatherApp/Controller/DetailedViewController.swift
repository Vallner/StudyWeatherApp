//
//  DetailedViewController.swift
//  StudyWeatherApp
//
//  Created by  on 21.05.25.
//

import UIKit

class DetailedViewController: UIViewController {

    weak var delegate:ViewController?
    
    var day : Forecastday?
    
    var forecastCollectionView: UICollectionView = {
        var layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: 120, height: 170)
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        
        var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(HourCollectionViewCell.self, forCellWithReuseIdentifier: "HourCollectionViewCell")
        collectionView.isScrollEnabled = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
 
        return collectionView
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
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1))
        forecastCollectionView.delegate = self
        forecastCollectionView.dataSource = self
        super.viewDidLoad()
        setupLayout()
        
        // Do any additional setup after loading the view.
    }
    
    func configureView(with day: Forecastday ){
        
        loadImage(from: day.day.condition.icon, to: imageView)
        
            self.day = day
            
            temperatureLabel.text = "\(day.day.avgtempC)" + "°"
            
            dateOfRequest.text = day.date
            
            cityLabel.text = delegate?.weather?.location.name
            
            descriptionLabel.text = day.day.condition.text
            
            windLabel.text = "\(day.day.avgvisKM) km/h"
            
            humidityLabel.text = "\(day.day.avghumidity)%"
            
            
        }
        
    
    
    func loadImage(from URL: String, to imageView: UIImageView) {
    Task{
        do{
            imageView.image =  try await UIImage(data: (delegate!.netManager.getImage(urlString: "https:" + URL))) ?? nil
        } catch {
            print(error)
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
        view.addSubview(forecastCollectionView)
       
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
            forecastCollectionView.topAnchor.constraint(equalTo: humidityLabel.bottomAnchor, constant: 20),
            forecastCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            forecastCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            forecastCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
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
extension DetailedViewController:UICollectionViewDelegate , UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(day?.hour.count ?? 0)
        return day?.hour.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HourCollectionViewCell", for: indexPath) as! HourCollectionViewCell
            cell.configure(with: day!.hour[indexPath.row])
            loadImage(from: day!.hour[indexPath.row].condition.icon, to: cell.image)
            cell.setupLayout()
            cell.layer.cornerRadius = 10
        print("oldCell",indexPath.row)
            return cell
//        }
//        let cell = HourCollectionViewCell()
//        loadImage(from: day!.hour[indexPath.row].condition.icon, to: cell.image)
//        cell.configure(with: day!.hour[indexPath.row])
//        cell.setupLayout()
//        print("newCell")
//        return cell
//        
    }
    
    
}

