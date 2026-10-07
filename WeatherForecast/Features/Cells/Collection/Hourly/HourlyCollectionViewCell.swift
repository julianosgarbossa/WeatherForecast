//
//  HourlyCollectionViewCell.swift
//  WeatherForecast
//
//  Created by Juliano Sgarbossa on 07/10/26.
//

import UIKit

class HourlyCollectionViewCell: UICollectionViewCell {
    static let identifier: String = String(describing: HourlyCollectionViewCell.self)
    
    private lazy var screen: HourlyCollectionViewCellScreen = {
        let screen = HourlyCollectionViewCellScreen()
        screen.translatesAutoresizingMaskIntoConstraints = false
        return screen
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addVisualElements()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addVisualElements() {
        contentView.addSubview(screen)
        
        configConstraints()
    }
    
    private func configConstraints() {
        NSLayoutConstraint.activate([
            screen.topAnchor.constraint(equalTo: contentView.topAnchor),
            screen.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            screen.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            screen.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
    
    func setupCell(forecast: Forecast) {
        screen.hourLabel.text = forecast.dt.toHourFormat()
        screen.tempLabel.text = forecast.temp.toCelsius()
        screen.weatherImageView.image = UIImage(named: forecast.weather[0].icon)
    }
}
