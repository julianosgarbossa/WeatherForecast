//
//  ForecastResponse.swift
//  WeatherForecast
//
//  Created by Juliano Sgarbossa on 07/10/26.
//

import Foundation

struct ForecastResponse: Decodable {
    let current: Forecast
    let hourly: [Forecast]
    let daily: [DailyForecast]
}

struct Forecast: Decodable {
    let dt: Int
    let temp: Double
    let humidity: Int
    let windSpeed: Double
    let weather: [Weather]
    
    enum CodingKeys: String, CodingKey {
        case dt
        case temp
        case humidity
        case windSpeed = "wind_speed"
        case weather
    }
}

struct Weather: Decodable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct DailyForecast: Decodable {
    let dt: Int
    let temp: Temp
    let weather: [Weather]
}

struct Temp: Decodable {
    let day: Double
    let min: Double
    let max: Double
    let night: Double
    let eve: Double
    let morn: Double
}
