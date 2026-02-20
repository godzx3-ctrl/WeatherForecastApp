//
//  Untitled.swift
//  weatherForecastApp
//
//  Created by Hanjuheon on 2/20/26.
//

import UIKit
import SnapKit
import Then

/// 과거 날씨 정보 컬랙션 셀
class ForecastCell: UICollectionViewCell {
    
    //MARK: - Properties
    static let identifier = "ForecastCell"
    
    //MARK: - Components
    /// 과거 날씨 정보 뷰
    let forecastView = ForecastView()
    
    //MARK: - INIT
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    required init?(coder: NSCoder) {
        fatalError("ForecastCell init(code:) Error")
    }
}

//MARK: - METHOD: Configure
extension ForecastCell {
    private func configureUI() {
        addSubview(forecastView)
        backgroundColor = .red
        
        forecastView.snp.makeConstraints {
            $0.directionalEdges.equalToSuperview()
        }
    }
}

#Preview {
    ForecastCell()
}
