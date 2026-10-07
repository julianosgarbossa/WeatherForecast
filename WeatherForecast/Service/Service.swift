//
//  Service.swift
//  WeatherForecast
//
//  Created by Juliano Sgarbossa on 07/10/26.
//

import Foundation

enum NetworkError: Error {
    case invalidURL(url: String)
    case requestError(error: String)
    case invalidResponse(statusCode: Int)
    case noData
    case decodingError(name: String, error: Error)
}

class Service {
    func fetchForecast(completion: @escaping (Result<ForecastResponse, NetworkError>) -> Void) {
        let urlString = "https://gist.githubusercontent.com/julianosgarbossa/a1cefbcad8fe943f90a00ee1bb47d2be/raw/787806bb7cc055e3097940530b0e7b093c28440a/forecast.json"
        
        guard let url = URL(string: urlString) else {
            completion(.failure(.invalidURL(url: urlString)))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil {
                DispatchQueue.main.async {
                    completion(.failure(.requestError(error: error?.localizedDescription ?? "")))
                }
                return
            }
            
            guard let response = response as? HTTPURLResponse,
                  response.statusCode == 200 else {
                let statusCode = (response as? HTTPURLResponse)?.statusCode ?? 0
                DispatchQueue.main.async {
                    completion(.failure(.invalidResponse(statusCode: statusCode)))
                }
                return
            }
            
            guard let data else {
                DispatchQueue.main.async {
                    completion(.failure(.noData))
                }
                return
            }
            
            do {
                let forecastResponse = try JSONDecoder().decode(ForecastResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(forecastResponse))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(.decodingError(name: "ForecastResponse", error: error)))
                }
            }
        }
        task.resume()
    }
}
