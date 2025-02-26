//
//  HourlyCollectionViewCell.swift
//  WeatherForecast
//
//  Created by Juliano Sgarbossa on 26/02/25.
//

import UIKit

class HourlyCollectionViewCell: UICollectionViewCell {
    
    static let identifier: String = String(describing: HourlyCollectionViewCell.self)
    
    private lazy var hourLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Typography.label
        label.text = "13:00"
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    private lazy var weatherImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "sunIcon")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var tempLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Typography.tempLabel
        label.text = "25ºC"
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setVisualElements()
        self.configLayoutCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configLayoutCell() {
        self.contentView.backgroundColor = .clear
        self.contentView.layer.cornerRadius = 20
        self.contentView.layer.borderWidth = 2
        self.contentView.layer.borderColor = Colors.lightBlue.cgColor
    }
    
    private func setVisualElements() {
        self.contentView.addSubview(hourLabel)
        self.contentView.addSubview(weatherImageView)
        self.contentView.addSubview(tempLabel)
        
        self.setConstraints()
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            hourLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            hourLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            hourLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            
            weatherImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            weatherImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -2),
            weatherImageView.heightAnchor.constraint(equalToConstant: 30),
            weatherImageView.widthAnchor.constraint(equalToConstant: 30),
            
            tempLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            tempLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            tempLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
        ])
    }
}
