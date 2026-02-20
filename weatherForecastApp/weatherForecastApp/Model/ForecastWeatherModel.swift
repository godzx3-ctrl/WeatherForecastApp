//
//  ForecastWeatherResult.swift
//  weatherForecastApp
//
//  Created by Hanjuheon on 2/12/26.
//


import Foundation

struct ForecastWeatherModel: Decodable {
    let list: [ForecastWeather]
}

struct ForecastWeather: Decodable {
    let main: Main
    let dtText: String
    
     enum CodingKeys: String, CodingKey {
        case main
        case dtText = "dt_txt"
    }
}

