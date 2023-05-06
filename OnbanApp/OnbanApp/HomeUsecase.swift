import Foundation

class HomeUsecase: UseCase {

    var usingData: [MealData]
    var repository: Repository
    var serialQueue: DispatchQueue

    init() {
        self.usingData = Array(repeating: MealData(), count: 3)
        self.repository = HomeRepository()
        self.serialQueue = DispatchQueue(label: "Homeimage")
    }
    
    subscript(index: Int) -> MealData {
        return usingData[index]
    }

    func loadAllData() {
        DispatchQueue.global().async {
            Task { await self.loadData(mealDataType: .main) }
            Task { await self.loadData(mealDataType: .side) }
            Task { await self.loadData(mealDataType: .soup) }
        }
    }

    func loadData(mealDataType: MealDataType) async {
        guard let mealData = await request(mealDataType: mealDataType) else {
            return
        }

        let storeIndex: Int
        switch mealDataType {
        case MealDataType.main:
            storeIndex = 0
        case MealDataType.soup:
            storeIndex = 1
        default:
            storeIndex = 2
        }
        usingData[storeIndex] = mealData

        let nameOfNotification: Notification.Name
        switch mealDataType {
        case .main:
            nameOfNotification = NotificationName.homeMain
        case .side:
            nameOfNotification = NotificationName.homeSide
        case .soup:
            nameOfNotification = NotificationName.homeSoup
        }
        
        NotificationCenter.default.post(name: nameOfNotification,
                                        object: nil)
    }

    func request(mealDataType: MealDataType) async -> MealData? {
        guard let responseData = await repository.request(data: mealDataType) else {
            return nil
        }

        return responseData
    }
}
