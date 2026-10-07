//
//  HomeScreen.swift
//  WeatherForecast
//
//  Created by Juliano Sgarbossa on 07/10/26.
//

import UIKit

class HomeScreen: UIView {

    private lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    private lazy var headerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        return view
    }()
    
    private lazy var cityNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Passo Fundo"
        label.font = Typography.subHeading
        label.textColor = Color.vibrantBlue
        label.textAlignment = .center
        return label
    }()
    
    private lazy var temperatureLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Color.vibrantBlue
        label.textAlignment = .left
        label.font = Typography.heading
        return label
    }()
    
    private lazy var weatherIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var statsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 15
        stackView.backgroundColor = Color.lightBlue
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
    
    private lazy var humidityTitleLabel: UILabel = {
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
    
    private lazy var windTitleLabel: UILabel = {
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
        label.textColor = .white
        return label
    }()
    
    private lazy var hourlyForecastTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Typography.label
        label.text = "PREVISÃO POR HORA"
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    lazy var hourlyCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(HourlyCollectionViewCell.self, forCellWithReuseIdentifier: HourlyCollectionViewCell.identifier)
        return collectionView
    }()
    
    private lazy var dailyForecastTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Typography.label
        label.text = "PRÓXIMOS DIAS"
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    lazy var dailyTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.separatorColor = Color.lightBlue
        tableView.separatorInset = UIEdgeInsets.zero
        tableView.layoutMargins = UIEdgeInsets.zero
        tableView.showsVerticalScrollIndicator = false
        tableView.register(DailyTableViewCell.self, forCellReuseIdentifier: DailyTableViewCell.identifier)
        return tableView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addVisualElements()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addVisualElements() {
        backgroundColor = .white
        
        addSubview(backgroundImageView)
        addSubview(headerView)
        headerView.addSubview(cityNameLabel)
        headerView.addSubview(temperatureLabel)
        headerView.addSubview(weatherIconImageView)
        addSubview(statsStackView)
        addSubview(hourlyForecastTitleLabel)
        addSubview(hourlyCollectionView)
        addSubview(dailyForecastTitleLabel)
        addSubview(dailyTableView)
        
        statsStackView.addArrangedSubview(humidityStackView)
        statsStackView.addArrangedSubview(windStackView)
        
        humidityStackView.addArrangedSubview(humidityTitleLabel)
        humidityStackView.addArrangedSubview(humidityValueLabel)
        
        windStackView.addArrangedSubview(windTitleLabel)
        windStackView.addArrangedSubview(windValueLabel)
        
        configConstraints()
    }
    
    private func configConstraints() {
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            headerView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            headerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 35),
            headerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -35),
            headerView.heightAnchor.constraint(equalToConstant: 170),
            
            cityNameLabel.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 25),
            cityNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            cityNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            cityNameLabel.heightAnchor.constraint(equalToConstant: 20),
            
            temperatureLabel.topAnchor.constraint(equalTo: cityNameLabel.bottomAnchor, constant: 15),
            temperatureLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 25),
            
            weatherIconImageView.centerYAnchor.constraint(equalTo: temperatureLabel.centerYAnchor),
            weatherIconImageView.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -25),
            weatherIconImageView.widthAnchor.constraint(equalToConstant: 85),
            weatherIconImageView.heightAnchor.constraint(equalToConstant: 85),
            
            statsStackView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 25),
            statsStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            statsStackView.widthAnchor.constraint(equalToConstant: 200),
            
            hourlyForecastTitleLabel.topAnchor.constraint(equalTo: statsStackView.bottomAnchor, constant: 25),
            hourlyForecastTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            hourlyForecastTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            hourlyCollectionView.topAnchor.constraint(equalTo: hourlyForecastTitleLabel.bottomAnchor, constant: 15),
            hourlyCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            hourlyCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            hourlyCollectionView.heightAnchor.constraint(equalToConstant: 85),
            
            dailyForecastTitleLabel.topAnchor.constraint(equalTo: hourlyCollectionView.bottomAnchor, constant: 25),
            dailyForecastTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            dailyForecastTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            dailyTableView.topAnchor.constraint(equalTo: dailyForecastTitleLabel.bottomAnchor, constant: 15),
            dailyTableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 35),
            dailyTableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -35),
            dailyTableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    func configCollectionProtocols(delegate: UICollectionViewDelegate, dataSource: UICollectionViewDataSource) {
        hourlyCollectionView.delegate = delegate
        hourlyCollectionView.dataSource = dataSource
    }
    
    func configTableProtocols(delegate: UITableViewDelegate, dataSource: UITableViewDataSource) {
        dailyTableView.delegate = delegate
        dailyTableView.dataSource = dataSource
    }
    
    func setupView(forecast: Forecast) {
        backgroundImageView.image = UIImage(named: forecast.dt.isDayTime() ? "bg_day" : "bg_night")
        temperatureLabel.text = forecast.temp.toCelsius()
        weatherIconImageView.image = UIImage(named: forecast.weather[0].icon)
        humidityValueLabel.text = "\((forecast.humidity)) mm"
        windValueLabel.text = "\(forecast.windSpeed) km/h"
    }
}
