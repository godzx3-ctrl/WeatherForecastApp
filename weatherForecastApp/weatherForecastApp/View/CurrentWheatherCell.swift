//
//  CurrentWheatherCell.swift
//  weatherForecastApp
//
//  Created by Hanjuheon on 2/20/26.
//

import UIKit
import SnapKit
import Then

class CurrentWheatherCell: UICollectionViewCell {
    
    //MARK: - Properties
    static let identifier = "CurrentWheatherCell"
    
    //MARK: - Components
    let currentWheatherView = CurrentWheatherView()
    
    //MARK: - INIT
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("CurrentWheatherCell Error")
    }
}

//MARK: - METHOD: Configure
extension CurrentWheatherCell {
    private func configureUI() {
        addSubview(currentWheatherView)
        
        currentWheatherView.snp.makeConstraints {
            $0.directionalEdges.equalToSuperview()
        }
    }
}

#Preview {
    CurrentWheatherCell()
}
