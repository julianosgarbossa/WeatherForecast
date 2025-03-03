//
//  Service.swift
//  WeatherForecast
//
//  Created by Juliano Sgarbossa on 27/02/25.
//

import Foundation

struct City {
    let lat: String
    let lon: String
    let name: String
}

class Service {
    
//    private let UrlAPI: String = "https://api.openweathermap.org/data/3.0/onecall?lat={lat}&lon={lon}&exclude={part}&appid={API key}"
//    private let baseURL:String = "https://api.openweathermap.org/data/3.0/onecall"
//    private let apiKey:String = "4e3c02e27dc1382c25a05604d5e8b6c3"
    private let session = URLSession.shared
    
    func fetchData(city: City, completion: @escaping(ForecastResponse) -> Void) {
//        let urlString = "\(baseURL)?lat=\(city.lat)&lon=\(city.lon)&appid=\(apiKey)"
        
        // Vou usar a API Mockada para não precisar pagar pelo uso
        let urlString = "https://run.mocky.io/v3/821ec6b3-553e-4241-9888-b571c8e06da1"
        
        guard let url = URL(string: urlString) else { return }
        
        let task = session.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            
            do {
                let ForecastResponse = try JSONDecoder().decode(ForecastResponse.self, from: data)
                completion(ForecastResponse)
            } catch {
                print(error)
            }
        }
        
        task.resume()
    }
}

// MARK: - ForecastResponse
struct ForecastResponse: Codable {
    let current: Forecast
    let hourly: [Forecast]
    let daily: [DailyForecast]
}

// MARK: - Forecast
struct Forecast: Codable {
    let dt: Int
    let temp: Double
    let humidity: Int
    let windSpeed: Double
    let weather: [Weather]

    enum CodingKeys: String, CodingKey {
        case dt, temp, humidity
        case windSpeed = "wind_speed"
        case weather
    }
}

// MARK: - Weather
struct Weather: Codable {
    let id: Int
    let main, description, icon: String
}

// MARK: - DailyForecast
struct DailyForecast: Codable {
    let dt: Int
    let temp: Temp
    let weather: [Weather]
}

// MARK: - Temp
struct Temp: Codable {
    let day, min, max, night: Double
    let eve, morn: Double
}
