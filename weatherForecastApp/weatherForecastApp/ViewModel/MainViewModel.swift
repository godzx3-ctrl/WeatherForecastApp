//
//  MainViewModel.swift
//  weatherForecastApp
//
//  Created by Hanjuheon on 2/12/26.
//
import Foundation
import UIKit

class MainViewModel {
    
    //MARK: - Enum
    enum ViewType {
        /// 현재 날씨 뷰
        case currentWheatherView
        /// 과거 날씨 뷰
        case ForecastView
    }
    
    // MARK: - Closures
    /// 현재 날씨 UI 업데이트 요청 클로저
    var UpdateCurrentUIClousure: (()-> Void)?
    /// 과거 날씨 UI 업데이트 요청 클로저
    var UpdateForecastUIClosure: (()-> Void)?
    
    //MARK: - Properties
    /// API 클래스
    let openApi = OpenWeatherAPIService()
    /// 현재 정보 모델
    var currentWheaterModel: CurrentWeatherModel? = nil
    /// 과거 정보 모델
    var forecastWheaterModel: ForecastWeatherModel? = nil
    /// 기상 이미지
    var mainImage: UIImage? = nil
    /// 뷰 타입 지정
    var viewTypes: [ViewType] = [.currentWheatherView, .ForecastView]
    
    init() {
        requestCurrentWheaterData()
        requestForecastWheatherData()
    }
}

// MARK: - METHOD: API
extension MainViewModel {
    
    /// 현재 기상 정보 API 요청 메소드
    func requestCurrentWheaterData() {
        guard let url = weatherItem.getCurrentWeatherUrl(
            lat: "37.5665",
            lon: "126.9780",
            appid: APIKey.weatherApiKey,
            units: "metric"
        ) else {
            print("Create URL Failed")
            return
        }
        
        openApi.requestAPI(Url: url) { [weak self] (result: CurrentWeatherModel?) in
            guard let self, let result else { return }
            currentWheaterModel = result
            
            guard let imageUrl = URLComponents(string: "https://openweathermap.org/payload/api/media/file/10d@2x.png")?.url else
            {
                print("Create URL Failed")
                return
            }

            if let data = try? Data(contentsOf: imageUrl) {
                if let image = UIImage(data: data) {
                    self.mainImage = image
                }
            }
            
            DispatchQueue.main.async {
                self.UpdateCurrentUIClousure?()
            }
        }
    }
    
    /// 과거 기상 정보 API 요청 메소드
    func requestForecastWheatherData() {
        guard let url = weatherItem.getForecastWeatherUrl(
            lat: "37.5665",
            lon: "126.9780",
            appid: APIKey.weatherApiKey,
            units: "metric"
        ) else {
            print("Create URL Failed")
            return
        }
        
        openApi.requestAPI(Url: url) { [weak self] (result: ForecastWeatherModel?) in
            guard let self, let result else {
                return
            }
            forecastWheaterModel = result
            
            DispatchQueue.main.async{
                self.UpdateForecastUIClosure?()
            }
        }
    }
}
