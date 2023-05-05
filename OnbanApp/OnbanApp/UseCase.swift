//  Created by wood on 2023/05/03.

protocol UseCase {
    var usingData: [MealData] { get set }
    var repository: Repository { get set }

    func loadAllData()

    subscript(index: Int) -> MealData { get }
}
