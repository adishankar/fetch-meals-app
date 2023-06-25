//
//  MealsView.swift
//  fetch-meals-app
//
//  Created by Adi Shankar on 6/24/23.
//

import SwiftUI

struct MealsView: View {
    
    @State var meals = [MealViewModel]()
    
    var body: some View {
        List {
            ForEach(meals) { meal in
                Text(meal.mealName)
            }
        }
        .onAppear {
            Task {
                let mealsResult = await MealService.retrieveMeals("dessert")
                switch mealsResult {
                case .success(let mealsResponse):
                    let mealsViewModels = toViewModel(mealsResponse)
                    meals = mealsViewModels
                case .failure(_):
                    debugPrint("error retrieving meals")
                }
            }
        }
        .refreshable {
            Task {
                let mealsResult = await MealService.retrieveMeals("dessert")
                switch mealsResult {
                case .success(let mealsResponse):
                    let mealsViewModels = toViewModel(mealsResponse)
                    meals = mealsViewModels
                case .failure(_):
                    debugPrint("error retrieving meals")
                }
            }
        }
    }
    
    func toViewModel(_ mealsResponse: MealsResponse) -> [MealViewModel] {
        return mealsResponse.meals
            .compactMap { meal in
                return toViewModel(meal)
            }
    }
    
    func toViewModel(_ meal: Meal) -> MealViewModel? {
        if meal.idMeal.isEmpty || meal.strMeal.isEmpty {
            return nil
        }
        return MealViewModel(id: meal.idMeal, mealName: meal.strMeal, thumbnailUrl: meal.strMealThumb)
    }
}

struct MealsView_Previews: PreviewProvider {
    static var previews: some View {
        MealsView()
    }
}
