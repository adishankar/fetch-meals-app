//
//  MealsDataServiceProtocol.swift
//  fetch-meals-app
//
//  Created by Adi Shankar on 6/27/23.
//

import Foundation

protocol MealsDataServiceProtocol {
    
    func retrieveMeals(_ type: String) async -> Result<MealsResponse, NetworkError>
    
    func retrieveMealDetail(_ mealId: String) async -> Result<MealDetailResponse, NetworkError>
    
}
