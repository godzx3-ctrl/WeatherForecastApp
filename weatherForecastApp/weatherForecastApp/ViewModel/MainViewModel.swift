//
//  MainViewModel.swift
//  weatherForecastApp
//
//  Created by Hanjuheon on 2/12/26.
//
import Foundation
import UIKit

class MainViewModel {

    // MARK: - Closures
    var uiUpdateClousure: (()-> Void)?
    
    //MARK: - Properties
    let openApi = OpenWeatherAPIService()
    var currentWheaterModel: CurrentWeatherModel? = nil
    var mainImage: UIImage? = nil
}

// MARK: - METHOD: API
extension MainViewModel {
    func requestCurrentWheaterData() {
        guard let url = currentWeatherItem.getCurrentWeatherUrl(
            lat: "37.5665",
            lon: "126.9780",
            appid: APIKey.weatherApiKey,
            units: "metric"
        ) else {
            print("Create URL Failed")
            return
        }
        
        openApi.requestAPI(Url: url) {[weak self] (result: CurrentWeatherModel?) in
            guard let self, let result else { return }
            currentWheaterModel = result
            DispatchQueue.main.sync {
                self.uiUpdateClousure?()
            }
        }
        
        guard let imageUrl = currentWeatherItem.getImageUrl() else
        {
            print("Create URL Failed")
            return
        }
        
        openApi.loadImage(url: imageUrl) { [weak self] result in
            guard let self, let result else { return }
            mainImage = UIImage(data: result)
            DispatchQueue.main.sync {
                self.uiUpdateClousure?()
            }
        }
       
    }
}
