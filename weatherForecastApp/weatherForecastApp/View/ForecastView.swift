//
//  ForecastView.swift
//  weatherForecastApp
//
//  Created by Hanjuheon on 2/13/26.
//

import UIKit
import Then
import SnapKit

/// 과거 날씨 정보 뷰
class ForecastView: UIView {
    
    //MARK: - Components
    // 날짜 레이블
    private let dateLabel = UILabel().then {
        $0.font = UIFont.boldSystemFont(ofSize: 16)
        $0.numberOfLines = 1
        $0.textColor = .white
        $0.text = "0000-00-00 00:00:00"
        $0.textAlignment = .left
    }
    /// 온도 레이블
    private let tempLabel = UILabel().then {
        $0.font = UIFont.boldSystemFont(ofSize: 16)
        $0.numberOfLines = 1
        $0.textColor = .white
        $0.text = "--ºC"
        $0.textAlignment = .right
    }

    //MARK: - INIT
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("ForecastView coder Init Error")
    }
}

//MARK: - METHOD: UI Update
extension ForecastView {
    /// UI 업데이트 메소드
    func UpdateUI(date: String, temp: String) {
        dateLabel.text = date
        tempLabel.text = "\(temp) ºC"
    }
    
}

//MARK: - METHOD: Configure
extension ForecastView {
    /// 초기 UI 설정 메소드
    private func configureUI() {
        let stackView = UIStackView().then {
            $0.axis = .horizontal
            $0.distribution = .fill
            $0.spacing = 10
            $0.alignment = .center
            $0.backgroundColor = .black
        }
        
        stackView.addArrangedSubview(dateLabel)
        stackView.addArrangedSubview(tempLabel)
        addSubview(stackView)
        
        stackView.snp.makeConstraints {
            $0.directionalEdges.equalToSuperview()
        }
    }
}


#Preview{
    ForecastView()
}
