//
//  DailyTableViewCellScreen.swift
//  WeatherForecast
//
//  Created by Juliano Sgarbossa on 07/10/26.
//

import UIKit

class DailyTableViewCellScreen: UIView {
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 40
        stackView.alignment = .center
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        return stackView
    }()
    
    lazy var weekDayLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Typography.label
        label.textColor = .white
        label.textAlignment = .left
        return label
    }()
    
    lazy var weatherImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var minTemperatureLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Typography.tempLabel
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    lazy var maxTemperatureLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Typography.tempLabel
        label.textColor = .white
        label.textAlignment = .right
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addVisualElements()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addVisualElements() {
        addSubview(stackView)
        
        stackView.addArrangedSubview(weekDayLabel)
        stackView.addArrangedSubview(weatherImageView)
        stackView.addArrangedSubview(minTemperatureLabel)
        stackView.addArrangedSubview(maxTemperatureLabel)
        
        configConstraints()
    }
    
    private func configConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            weekDayLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 40),
            
            weatherImageView.heightAnchor.constraint(equalToConstant: 20),
            weatherImageView.widthAnchor.constraint(equalToConstant: 20),
        ])
    }
}
