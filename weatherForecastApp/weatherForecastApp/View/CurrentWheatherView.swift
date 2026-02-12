//
//  CurrentWheatherView.swift
//  weatherForecastApp
//
//  Created by Hanjuheon on 2/12/26.
//

import UIKit
import Then
import SnapKit

/// 메인 날씨 정보 뷰
class CurrentWheatherView : UIView {
    
    /// 도시 이름 라벨
    private let cityLabel = UILabel().then {
        $0.text = "서울특별시"
        $0.textColor = .white
        $0.font = UIFont.boldSystemFont(ofSize: 30)
    }
    /// 현재 온도 라벨
    private  let currentTemp = UILabel().then {
        $0.text = "20ºC"
        $0.font = UIFont.boldSystemFont(ofSize: 50)
        $0.textColor = .white
    }
    /// 최소 온도 라벨
    private  let minTemp = UILabel().then {
        $0.text = "10ºC"
        $0.font = UIFont.boldSystemFont(ofSize: 20)
        $0.textColor = .white
    }
    /// 최대 온도 라벨
    private let maxTemp = UILabel().then {
        $0.text = "30ºC"
        $0.font = UIFont.boldSystemFont(ofSize: 20)
        $0.textColor = .white
    }
    
    /// 날씨 이미지
    private let cloudImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("CurrentWheatherView Error")
    }
}

extension CurrentWheatherView {
    func UpdateUIData(cityName: String, currentTemp: Float, minTemp: Float, maxTemp: Float) {
        cityLabel.text = cityName
        self.currentTemp.text =
        "\(currentTemp)ºC"
        self.minTemp.text = "\(minTemp)ºC"
        self.maxTemp.text = "\(maxTemp)ºC"
    }
}

extension CurrentWheatherView {
    private func configureUI() {
        let MainStackView = UIStackView().then {
            $0.axis = .vertical
            $0.distribution = .equalCentering
            $0.spacing = 5
            $0.alignment = .center
        }
        
        let minMaxStackView = UIStackView().then {
            $0.axis = .horizontal
            $0.distribution = .fillProportionally
            $0.spacing = 5
            $0.alignment = .center
        }
        
        let minTitleLabel = UILabel().then {
            $0.text = "최소"
            $0.font = UIFont.boldSystemFont(ofSize: 20)
            $0.textColor = .white
        }
        
        
        let maxTitleLabel = UILabel().then {
            $0.text = "최대"
            $0.font = UIFont.boldSystemFont(ofSize: 20)
            $0.textColor = .white
        }
        
        [minTitleLabel, minTemp, maxTitleLabel, maxTemp].forEach {
            minMaxStackView.addArrangedSubview($0)
        }
        
        [cityLabel, currentTemp, minMaxStackView, cloudImageView].forEach {
            MainStackView.addArrangedSubview($0)
        }
        
        addSubview(MainStackView)
        
        MainStackView.snp.makeConstraints {
            $0.directionalEdges.equalToSuperview()
        }
    }
}

#Preview{
    CurrentWheatherView()
}
