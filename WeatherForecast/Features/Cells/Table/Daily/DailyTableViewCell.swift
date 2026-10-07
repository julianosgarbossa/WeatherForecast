//
//  DailyTableViewCell.swift
//  WeatherForecast
//
//  Created by Juliano Sgarbossa on 07/10/26.
//

import UIKit

class DailyTableViewCell: UITableViewCell {
    static let identifier: String = String(describing: DailyTableViewCell.self)
    
    private lazy var screen: DailyTableViewCellScreen = {
        let screen = DailyTableViewCellScreen()
        screen.translatesAutoresizingMaskIntoConstraints = false
        return screen
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addVisualElements()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addVisualElements() {
        backgroundColor = .clear
        selectionStyle = .none
        
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
    
    func setupCell(dailyForecast: DailyForecast) {
        screen.weekDayLabel.text = dailyForecast.dt.toWeekdayName().uppercased()
        screen.weatherImageView.image = UIImage(named: dailyForecast.weather[0].icon)
        screen.minTemperatureLabel.text = "min \(dailyForecast.temp.min.toCelsius())"
        screen.maxTemperatureLabel.text = "max \(dailyForecast.temp.max.toCelsius())"
    }
}
