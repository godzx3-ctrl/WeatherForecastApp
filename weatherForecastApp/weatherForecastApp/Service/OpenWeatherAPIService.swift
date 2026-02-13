//
//  OpenWeatherAPIService.swift
//  weatherForecastApp
//
//  Created by Hanjuheon on 2/12/26.
//

import Foundation

class OpenWeatherAPIService {
    /// API 호출 메소드
    func requestAPI<T: Decodable>(Url: URL, completion: @escaping (T?)-> Void) {
        let session = URLSession(configuration: .default)
        session.dataTask(with: URLRequest(url: Url)) { (data, response, error) in
            guard let data, error == nil else {
                print("DataLoad Failed")
                completion(nil)
                return
            }
            let successRsponseRange = 200..<300
            if let response = response as? HTTPURLResponse,
               successRsponseRange.contains(response.statusCode) {
                guard let decodeData = try? JSONDecoder().decode(T.self, from: data) else {
                    print("Decoding Failed")
                    completion(nil)
                    return
                }
                print("Decoding Success")
                completion(decodeData)
            } else {
                print("Connect Error")
                completion(nil)
                return
            }
        }.resume()
    }
    
    func loadImage(url: URL, completion: @escaping (Data?) -> Void) {
        let session = URLSession(configuration: .default)
        session.dataTask(with: URLRequest(url: url)) { (data, response, error) in
            guard let data, error == nil else {
                print("DataLoad Failed")
                completion(nil)
                return
            }
            
            let successResponseRange = 200..<300
            
            if let response = response as? HTTPURLResponse,
               successResponseRange.contains(response.statusCode) {
                completion(data)
            } else {
                print("Connect Error")
                completion(nil)
            }
        }.resume()
    }
    
}

enum currentWeatherItem: String {
    case currentWeatherUrl = "https://api.openweathermap.org/data/2.5/weather"
    case lat = "lat"
    case lon = "lon"
    case appid = "appid"
    case units = "units"
    
    
    static func getCurrentWeatherUrl(
        lat: String,
        lon: String,
        appid: String,
        units: String
    ) -> URL? {
        
        var urlComponents = URLComponents(string: currentWeatherItem.currentWeatherUrl.rawValue)
        
        urlComponents?.queryItems = [
            URLQueryItem(name: currentWeatherItem.lat.rawValue, value: lat),
            URLQueryItem(name: currentWeatherItem.lon.rawValue, value: lon),
            URLQueryItem(name: currentWeatherItem.appid.rawValue, value: appid),
            URLQueryItem(name: currentWeatherItem.units.rawValue, value: units),
        ]
        return urlComponents?.url
    }
    
    static func getImageUrl() -> URL? {
        return URLComponents(string: "https://openweathermap.org/payload/api/media/file/10d@2x.png")?.url
        
    }
    
}
