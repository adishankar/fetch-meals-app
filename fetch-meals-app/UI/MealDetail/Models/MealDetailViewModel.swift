//
//  MealDetailViewModel.swift
//  fetch-meals-app
//
//  Created by Adi Shankar on 6/26/23.
//

import Foundation

struct MealDetailViewModel {
    
    let mealId: String
    let mealName: String
    let imageUrl: String
    let videoUrl: String
    let sourceUrl: String?
    let area: String
    let tags: [String]
    let ingredients: [MealIngredientViewModel]
    let instructions: [String]
    
}
