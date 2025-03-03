//
//  DailyTableViewCell.swift
//  WeatherForecast
//
//  Created by Juliano Sgarbossa on 27/02/25.
//

import UIKit

class DailyTableViewCell: UITableViewCell {

    static let identifier: String = String(describing: DailyTableViewCell.self)
    
    private lazy var weakDayLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "TER"
        label.font = Typography.label
        label.textColor = .white
        return label
    }()
    
    private lazy var weatherImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "rainIcon")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var maxLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "max"
        label.font = Typography.label
        label.textColor = .white
        return label
    }()
    
    private lazy var maxValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "29"
        label.font = Typography.tempLabel
        label.textColor = .white
        return label
    }()
    
    private lazy var minLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "min"
        label.font = Typography.label
        label.textColor = .white
        return label
    }()
    
    private lazy var minValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "18"
        label.font = Typography.tempLabel
        label.textColor = .white
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setVisualElements()
        self.configLayoutCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setCell(weekDay: String?, min: String?, max: String?, icon: UIImage?) {
        self.weakDayLabel.text = weekDay
        self.weatherImageView.image = icon
        self.minValueLabel.text = min
        self.maxValueLabel.text = max
    }
    
    private func configLayoutCell() {
        self.contentView.backgroundColor = .clear
        self.backgroundColor = .clear
        self.selectionStyle = .none
    }
    
    private func setVisualElements() {
        self.contentView.addSubview(weakDayLabel)
        self.contentView.addSubview(weatherImageView)
        self.contentView.addSubview(maxValueLabel)
        self.contentView.addSubview(maxLabel)
        self.contentView.addSubview(minValueLabel)
        self.contentView.addSubview(minLabel)
        
        self.setConstraints()
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            weakDayLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            weakDayLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            weakDayLabel.widthAnchor.constraint(equalToConstant: 40),
            
            weatherImageView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            weatherImageView.leadingAnchor.constraint(equalTo: weakDayLabel.trailingAnchor, constant: 50),
            weatherImageView.heightAnchor.constraint(equalToConstant: 20),
            weatherImageView.widthAnchor.constraint(equalToConstant: 20),
            
            maxValueLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            maxValueLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            maxValueLabel.widthAnchor.constraint(equalToConstant: 19),
            
            maxLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor, constant: 1),
            maxLabel.trailingAnchor.constraint(equalTo: maxValueLabel.leadingAnchor, constant: -3),
            
            minValueLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            minValueLabel.trailingAnchor.constraint(equalTo: maxLabel.leadingAnchor, constant: -55),
            minValueLabel.widthAnchor.constraint(equalToConstant: 19),
            
            minLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor, constant: 1),
            minLabel.trailingAnchor.constraint(equalTo: minValueLabel.leadingAnchor, constant: -3),
        ])
    }
}
