//
//  MockMealService.swift
//  fetch-meals-app
//
//  Created by Adi Shankar on 6/27/23.
//

import Foundation

class MockMealService: MealsDataServiceProtocol {
    
    let decoder = JSONDecoder()
    
    func retrieveMeals(_ type: String) async -> Result<MealsResponse, NetworkError> {
        guard let data = getFileData("meals") else {
            return .failure(.requestError)
        }
        do {
            let meals = try decoder.decode(MealsResponse.self, from: data)
            return .success(meals)
        } catch {
            return .failure(.requestError)
        }
    }
    
    func retrieveMealDetail(_ mealId: String) async -> Result<MealDetailResponse, NetworkError> {
        guard let data = getFileData("meal_detail_52891") else {
            return .failure(.requestError)
        }
        do {
            let mealDetail = try decoder.decode(MealDetailResponse.self, from: data)
            return .success(mealDetail)
        } catch {
            return .failure(.requestError)
        }
    }
    
    private func getFileData(_ fileName: String) -> Data? {
        guard let path = Bundle.main.path(forResource: fileName, ofType: "json") else {
            return nil
        }
        let file = URL(filePath: path)
        return try? Data(contentsOf: file)
    }
    
}
