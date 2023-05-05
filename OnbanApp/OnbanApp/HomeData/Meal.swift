// Created by wood on 2023/05/03.

// statusCode는 Request과정에서 확인 가능하므로 추가하지 않았습니다.
protocol Meal {
    var body: [MealDetails] { get set }
}
