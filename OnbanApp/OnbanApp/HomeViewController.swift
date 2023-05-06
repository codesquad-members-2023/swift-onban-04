import UIKit
import OSLog

let logger = Logger()

class HomeViewController: UIViewController {

    @IBOutlet var collectionView: UICollectionView!
    var homeUsecase: any UseCase = HomeUsecase()
    let homeSectionCount: Int = 3
    let homeCellCount: Int = 8

    override func viewDidLoad() {
        super.viewDidLoad()
        homeUsecase.loadAllData()
        registerAllObserver()
    }
}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath) as? HomeHeader else {
            return UICollectionReusableView()
        }

        let headerText: String
        switch indexPath.section {
        case 1:
            headerText = "정성과 건강이 가득 담긴 국물 요리"
        case 2:
            headerText = "식탁을 풍성하게 하는 정갈한 밑반찬"
        default:
            headerText = "온 가족이 좋아하는 든든한 메인 요리"
        }
        headerView.sectionName.text = headerText

        return headerView
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return homeSectionCount
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: self.view.frame.width, height: 96)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return homeCellCount
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? HomeMenuCell else {
            logger.log("HomeMenuCell의 Data를 가져오는데 실패했습니다.")
            return UICollectionViewCell()
        }

        guard let sectionData = homeUsecase[indexPath.section] as? MealData else {
            return cell
        }
        
        guard !sectionData.body.isEmpty else {
            return cell
        }
        let cellData = sectionData.body[indexPath.row]

        cell.foodName.text        = cellData.title
        cell.foodDescription.text = cellData.description
        cell.price.text           = cellData.sellPrice
        if let original = cellData.price {
            cell.originalPrice.text = original
        } else {
            cell.originalPrice.text = ""
        }

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: 130)
    }
}

extension HomeViewController: UICollectionViewDelegate { }

extension HomeViewController {
    
    func registerAllObserver() {
        registerObserver(mealDataType: .main)
        registerObserver(mealDataType: .side)
        registerObserver(mealDataType: .soup)
    }
    
    func registerObserver(mealDataType: MealDataType) {
        
        let nameOfNotification: Notification.Name
        switch mealDataType {
        case .main:
            nameOfNotification = NotificationName.homeMain
        case .side:
            nameOfNotification = NotificationName.homeSide
        case .soup:
            nameOfNotification = NotificationName.homeSoup
        }
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(updateCell(_:)),
                                               name: nameOfNotification,
                                               object: nil)
    }

    @objc func updateCell(_ notification: Notification) {

        let notifiedName = notification.name

        let sectionRange: ClosedRange<Int>
        switch notifiedName {
        case NotificationName.homeMain:
            sectionRange = 0...0
        case NotificationName.homeSide:
            sectionRange = 1...1
        default:
            sectionRange = 2...2
        }
        
        DispatchQueue.main.async {
            self.collectionView.reloadSections(IndexSet(sectionRange))
        }
    }
}
