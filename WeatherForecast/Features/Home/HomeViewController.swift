//
//  HomeViewController.swift
//  WeatherForecast
//
//  Created by Juliano Sgarbossa on 26/02/25.
//

import UIKit

class HomeViewController: UIViewController {

    private let service = Service()
    private var forecastResponse: ForecastResponse?
    private let city = City(lat: "28.2612", lon: "-52.4083", name: "Chicago")
    
    private lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "background")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var backgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Colors.lightGray
        view.layer.cornerRadius = 20
        return view
    }()
    
    private lazy var cityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Colors.vibrantBlue
        label.textAlignment = .center
        label.text = "São Paulo"
        label.font = Typography.subHeading
        return label
    }()
    
    private lazy var tempLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Colors.vibrantBlue
        label.textAlignment = .center
        label.text = "25ºC"
        label.font = Typography.heading
        return label
    }()
    
    private lazy var weatherImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "sunIcon")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var statsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 15
        stackView.backgroundColor = Colors.lightBlue
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 15, leading: 15, bottom: 15, trailing: 15)
        stackView.layer.cornerRadius = 10
        return stackView
    }()
    
    private lazy var humidityStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 25
        return stackView
    }()
    
    private lazy var humidityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Typography.label
        label.text = "Umidade"
        label.textColor = .white
        return label
    }()
    
    private lazy var humidityValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Typography.label
        label.text = "1000mm"
        label.textColor = .white
        return label
    }()
    
    private lazy var windStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 25
        return stackView
    }()
    
    private lazy var windLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Typography.label
        label.text = "Vento"
        label.textColor = .white
        return label
    }()
    
    private lazy var windValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Typography.label
        label.text = "10km/h"
        label.textColor = .white
        return label
    }()
    
    private lazy var hourlyForecastLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Typography.label
        label.text = "PREVISÃO POR HORA"
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    private lazy var hourlyCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 70, height: 85)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.register(HourlyCollectionViewCell.self, forCellWithReuseIdentifier: HourlyCollectionViewCell.identifier)
        collectionView.delegate = self
        return collectionView
    }()
    
    private lazy var dailyForecastLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Typography.label
        label.text = "PRÓXIMOS DIAS"
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    private lazy var dailyTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.separatorColor = Colors.lightBlue
        tableView.separatorInset = UIEdgeInsets.zero
        tableView.layoutMargins = UIEdgeInsets.zero
        tableView.showsVerticalScrollIndicator = false
        tableView.dataSource = self
        tableView.register(DailyTableViewCell.self, forCellReuseIdentifier: DailyTableViewCell.identifier)
        tableView.delegate = self
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setVisualElements()
        self.fecthData()
    }
    
    private func fecthData() {
        self.service.fetchData(city: city) { [weak self] response in
            self?.forecastResponse = response
            DispatchQueue.main.async {
                self?.loadData()
            }
        }
    }
    
    private func loadData() {
        cityLabel.text = city.name
        let tempCelsius = self.kelvinToCelsius(forecastResponse?.current.temp ?? 0)
        tempLabel.text = tempCelsius
        humidityValueLabel.text = "\(forecastResponse?.current.humidity ?? 0)mm"
        windValueLabel.text = "\(forecastResponse?.current.windSpeed ?? 0)km/h"
        
        self.hourlyCollectionView.reloadData()
        self.dailyTableView.reloadData()
    }
    
    // Converte temperatura de kelvin para celsius
    func kelvinToCelsius(_ kelvin: Double) -> String {
        let celsius = kelvin - 273.15
        return String(format: "%.0fºC", celsius) // Arredonda para número inteiro
    }
    
    private func setVisualElements() {
        view.addSubview(backgroundImageView)
        view.addSubview(backgroundView)
        view.addSubview(cityLabel)
        view.addSubview(tempLabel)
        view.addSubview(weatherImageView)
        view.addSubview(statsStackView)
        view.addSubview(hourlyForecastLabel)
        view.addSubview(hourlyCollectionView)
        view.addSubview(dailyForecastLabel)
        view.addSubview(dailyTableView)
        
        statsStackView.addArrangedSubview(humidityStackView)
        statsStackView.addArrangedSubview(windStackView)
        
        humidityStackView.addArrangedSubview(humidityLabel)
        humidityStackView.addArrangedSubview(humidityValueLabel)
        
        windStackView.addArrangedSubview(windLabel)
        windStackView.addArrangedSubview(windValueLabel)
        
        self.setConstraints()
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            backgroundView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 35),
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -35),
            backgroundView.heightAnchor.constraint(equalToConstant: 170),
            
            cityLabel.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 25),
            cityLabel.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 15),
            cityLabel.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -15),
            cityLabel.heightAnchor.constraint(equalToConstant: 20),
            
            tempLabel.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 15),
            tempLabel.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 25),
            
            weatherImageView.centerYAnchor.constraint(equalTo: tempLabel.centerYAnchor),
            weatherImageView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -25),
            weatherImageView.leadingAnchor.constraint(equalTo: tempLabel.trailingAnchor, constant: 15),
            weatherImageView.heightAnchor.constraint(equalToConstant: 85),
            weatherImageView.widthAnchor.constraint(equalToConstant: 85),
            
            statsStackView.topAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: 20),
            statsStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            statsStackView.widthAnchor.constraint(equalToConstant: 200),
            
            hourlyForecastLabel.topAnchor.constraint(equalTo: statsStackView.bottomAnchor, constant: 20),
            hourlyForecastLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            hourlyCollectionView.topAnchor.constraint(equalTo: hourlyForecastLabel.bottomAnchor, constant: 20),
            hourlyCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hourlyCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            hourlyCollectionView.heightAnchor.constraint(equalToConstant: 85),
            
            dailyForecastLabel.topAnchor.constraint(equalTo: hourlyCollectionView.bottomAnchor, constant: 20),
            dailyForecastLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            dailyTableView.topAnchor.constraint(equalTo: dailyForecastLabel.bottomAnchor, constant: 20),
            dailyTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 35),
            dailyTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -35),
            dailyTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.forecastResponse?.hourly.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HourlyCollectionViewCell.identifier, for: indexPath) as? HourlyCollectionViewCell else { return UICollectionViewCell()}
        let forecast = forecastResponse?.hourly[indexPath.row]
        cell.setCell(time: forecast?.dt.toHourFormat(), icon: UIImage(named: "sunIcon"), temp: forecast?.temp.toCelsius())
        return cell
    }
}

extension HomeViewController: UICollectionViewDelegate {
    
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.forecastResponse?.daily.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DailyTableViewCell.identifier, for: indexPath) as? DailyTableViewCell else { return UITableViewCell() }
        let forecast = forecastResponse?.daily[indexPath.row]
        cell.setCell(weekDay: forecast?.dt.toWeekdayName().uppercased(), min: forecast?.temp.min.toCelsius(), max: forecast?.temp.max.toCelsius(), icon: UIImage(named: "rainIcon"))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

extension HomeViewController: UITableViewDelegate {
    
}


