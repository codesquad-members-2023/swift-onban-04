//  Created by wood on 2023/05/05.

import Foundation

struct MealData: Decodable, Meal {
    var body: [MealDetails]
    
    init() {
        self.body = []
    }
}
