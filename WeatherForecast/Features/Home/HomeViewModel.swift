//
//  HomeViewModel.swift
//  WeatherForecast
//
//  Created by Juliano Sgarbossa on 07/10/26.
//

import Foundation

protocol HomeViewModelDelegate: AnyObject {
    func success()
    func failure(error: String)
}

final class HomeViewModel {
    
    private weak var delegate: HomeViewModelDelegate?
    
    func delegate(delegate: HomeViewModelDelegate) {
        self.delegate = delegate
    }
    
    private let service: Service = Service()
    private var forecastResponse: ForecastResponse?
    
    var numberOfItemsInSection: Int {
        return forecastResponse?.hourly.count ?? 0
    }
    
    var sizeForItemAt: CGSize {
        return CGSize(width: 70, height: 85)
    }
    
    var numberOfRowsInSection: Int {
        return forecastResponse?.daily.count ?? 0
    }
    
    var heightForRowAt: CGFloat {
        return CGFloat(50)
    }
    
    var loadCurrentForecast: Forecast {
        return forecastResponse?.current ?? Forecast(dt: 0, temp: 0.0, humidity: 0, windSpeed: 0.0, weather: [])
    }
    
    func loadCurrentForecst(index: Int) -> Forecast {
        return forecastResponse?.hourly[index] ?? Forecast(dt: 0, temp: 0.0, humidity: 0, windSpeed: 0.0, weather: [])
    }
    
    func loadCurrentDailyForecast(index: Int) -> DailyForecast {
        return forecastResponse?.daily[index] ?? DailyForecast(dt: 0, temp: Temp(day: 0.0, min: 0.0, max: 0.0, night: 0.0, eve: 0.0, morn: 0.0), weather: [])
    }
    
    func fetchForecast() {
        service.fetchForecast { [weak self] result in
            switch result {
            case .success(let forecastResponse):
                self?.forecastResponse = forecastResponse
                self?.delegate?.success()
            case .failure(let error):
                self?.delegate?.failure(error: error.localizedDescription)
            }
        }
    }
}
