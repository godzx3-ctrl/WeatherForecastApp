//
//  CurrentWeatherReuslt.swift
//  weatherForecastApp
//
//  Created by Hanjuheon on 2/12/26.
//

import Foundation

struct CurrentWeatherModel: Decodable {
    let weather: [Weather]
    let main: Main
    let name: String
}

struct Weather: Decodable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct Main: Decodable {
    let temp: Float
    let feelslike: Float
    let tempmin: Float
    let tempmax: Float
    let pressure: Int
    let humidity: Int
    let Sealevel: Int
    let grndlevel: Int
    
    enum CodingKeys: String, CodingKey {
        case temp
        case feelslike = "feels_like"
        case tempmin = "temp_min"
        case tempmax = "temp_max"
        case pressure
        case humidity
        case Sealevel = "sea_level"
        case grndlevel = "grnd_level"
    }
}
