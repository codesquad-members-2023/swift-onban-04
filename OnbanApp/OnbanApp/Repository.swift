//  Created by 1 on 2023/05/05.

import Foundation

protocol Repository {
    func request(data type: MealDataType) async -> MealData?
}
