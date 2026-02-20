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
    /// 날씨 뷰모델
    private let vm = MainViewModel()
    
    //MARK: - Components
    /// 날씨 메인 콜렉션 뷰
    private var mainCollectionView: UICollectionView! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setClosureRefreshForecastView()
        configureUI()

        // Do any additional setup after loading the view.
    }
}

// MARK: - METHOD: setClosures
extension ViewController {
    /// 과거 뷰 UI업데이트 클로져 선언 메소드
    private func setClosureRefreshForecastView() {
        vm.UpdateForecastUIClosure = {[weak self] in
            guard let self else { return }
            self.mainCollectionView.reloadData()
        }
    }
}

//MARK: - METHOD: SET CollectionView 
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return vm.viewTypes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let sectionType = vm.viewTypes[section]
        
        switch sectionType {
        case .currentWheatherView:
            return 1
        case .ForecastView:
            return vm.forecastWheaterModel?.list.count ?? 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch vm.viewTypes[indexPath.section] {
        case .currentWheatherView:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: CurrentWheatherCell.identifier,
                for: indexPath) as! CurrentWheatherCell
            vm.UpdateCurrentUIClousure = { [weak self] in
                guard let self else { return }
                cell.currentWheatherView.UpdateUIData (
                    cityName: vm.currentWheaterModel?.name ?? "",
                    currentTemp: vm.currentWheaterModel?.main.temp ?? 0.0,
                    minTemp: vm.currentWheaterModel?.main.tempmin ?? 0.0,
                    maxTemp: vm.currentWheaterModel?.main.tempmax ?? 0.0,
                    image: vm.mainImage
                )
            }
            
            
            return cell
        case .ForecastView:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ForecastCell.identifier,
                for: indexPath) as! ForecastCell
            guard let item = vm.forecastWheaterModel?.list[indexPath.item]
            else { return cell }
            cell.forecastView.UpdateUI(date: item.dtText, temp: String(item.main.temp))
            return cell
        }
    }
    
    
    
}


// MARK: - METHOD: Set Compositional Layout
extension ViewController {
    /// 뷰 타입에 따른 섹션 선택 메소드
    private func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { [weak self] ( sectionIndex, _) -> NSCollectionLayoutSection? in
            guard let self else { return nil }
            let sectionType = vm.viewTypes[sectionIndex]
            
            switch sectionType {
            case .currentWheatherView:
                return getCurrentViewSection()
            case .ForecastView:
                return getForecastSection()
            }
        }
    }
    /// 현재날씨 관련 뷰 섹션 선언 메소드
    private func getCurrentViewSection()-> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: .init(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .estimated(300)
            )
        )
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: .init(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .estimated(300))
            , subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 10, leading: 0, bottom: 10, trailing: 0)
        
        return section
    }
    
    /// 과거날씨 관련 뷰 섹션 선언 메소드
    private func getForecastSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: .init(widthDimension: .fractionalWidth(1.0),
                              heightDimension: .absolute(40))
        )
        
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: .init(widthDimension: .fractionalWidth(1.0),
                              heightDimension: .estimated(40))
            , subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 10, leading: 0, bottom: 10, trailing: 0)
        
        return section
    }
}

// MARK: - METHOD: Configure UI
extension ViewController {
    /// 초기 UI 설정 메소드
    private func configureUI() {
        mainCollectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        mainCollectionView.backgroundColor = .black
        
        mainCollectionView.register(CurrentWheatherCell.self, forCellWithReuseIdentifier: CurrentWheatherCell.identifier)
        mainCollectionView.register(ForecastCell.self, forCellWithReuseIdentifier: ForecastCell.identifier)
        
        mainCollectionView.dataSource = self
        
        view.addSubview(mainCollectionView)
        
        mainCollectionView.snp.makeConstraints{
            $0.directionalEdges.equalToSuperview()
        }
    }
}


#Preview {
    ViewController()
}
