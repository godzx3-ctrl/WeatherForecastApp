//
//  ViewController.swift
//  weatherForecastApp
//
//  Created by Hanjuheon on 2/12/26.
//

import UIKit
import SnapKit
import Then

class ViewController: UIViewController {
    
    //MARK: - ViewModel
    private let vm = MainViewModel()
    
    //MARK: - Components
    private let currentWheatherView = CurrentWheatherView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        configureUI()
        setClosureRefreshCurrentView()
        vm.requestCurrentWheaterData()
        // Do any additional setup after loading the view.
    }
}



// MARK: - METHOD: setClosures
extension ViewController {
    private func setClosureRefreshCurrentView() {
        vm.uiUpdateClousure = { [weak self] in
            guard let self else { return }
            self.currentWheatherView.UpdateUIData(
                cityName: vm.currentWheaterModel?.name ?? "",
                currentTemp: vm.currentWheaterModel?.main.temp ?? 0.0,
                minTemp: vm.currentWheaterModel?.main.tempmin ?? 0.0,
                maxTemp: vm.currentWheaterModel?.main.tempmax ?? 0.0,
                image: vm.mainImage
            )
        }
    }
}

// MARK: - METHOD: Configure UI
extension ViewController {
    private func configureUI() {
        view.addSubview(currentWheatherView)
        currentWheatherView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(200)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(300)
        }
    }
}


#Preview {
    ViewController()
}
