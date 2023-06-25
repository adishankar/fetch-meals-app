//
//  MealService.swift
//  fetch-meals-app
//
//  Created by Adi Shankar on 6/24/23.
//

import Foundation

class MealService {
    
    private static let decoder = JSONDecoder()
    
    private static let MEALS_BASE_URL = "https://themealdb.com/api/json/v1/1"
    
    public static func retrieveMeals(_ type: String) async -> Result<MealsResponse, NetworkError> {
        
        // build get all meals url
        let components = URLComponents(string: MEALS_BASE_URL + "/filter.php?c=\(type)")
        guard let url = components?.url else {
            return .failure(NetworkError.urlError)
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let mealsResponse = try decoder.decode(MealsResponse.self, from: data)
            return .success(mealsResponse)
        } catch (let error) {
            debugPrint(error)
            return .failure(NetworkError.requestError)
        }
    }
    
}
