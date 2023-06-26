//
//  MealDetail.swift
//  fetch-meals-app
//
//  Created by Adi Shankar on 6/26/23.
//

import Foundation

class MealDetail: NSObject, Codable {
    
    let idMeal: String
    let strMeal: String
    let strDrinkAlternate: String?
    let strCategory: String
    let strArea: String
    let strInstructions: String
    let strMealThumb: String
    let strTags: String?
    let strYoutube: String
    
    // Working with the assumption that there can be up to 20 ingredient and amount fields
    @objc var strIngredient1: String?
    @objc var strIngredient2: String?
    @objc var strIngredient3: String?
    @objc var strIngredient4: String?
    @objc var strIngredient5: String?
    @objc var strIngredient6: String?
    @objc var strIngredient7: String?
    @objc var strIngredient8: String?
    @objc var strIngredient9: String?
    @objc var strIngredient10: String?
    @objc var strIngredient11: String?
    @objc var strIngredient12: String?
    @objc var strIngredient13: String?
    @objc var strIngredient14: String?
    @objc var strIngredient15: String?
    @objc var strIngredient16: String?
    @objc var strIngredient17: String?
    @objc var strIngredient18: String?
    @objc var strIngredient19: String?
    @objc var strIngredient20: String?
    
    @objc var strMeasure1: String?
    @objc var strMeasure2: String?
    @objc var strMeasure3: String?
    @objc var strMeasure4: String?
    @objc var strMeasure5: String?
    @objc var strMeasure6: String?
    @objc var strMeasure7: String?
    @objc var strMeasure8: String?
    @objc var strMeasure9: String?
    @objc var strMeasure10: String?
    @objc var strMeasure11: String?
    @objc var strMeasure12: String?
    @objc var strMeasure13: String?
    @objc var strMeasure14: String?
    @objc var strMeasure15: String?
    @objc var strMeasure16: String?
    @objc var strMeasure17: String?
    @objc var strMeasure18: String?
    @objc var strMeasure19: String?
    @objc var strMeasure20: String?
    
    let strSource: String
    let strImageSource: String?
    let strCreativeCommonsConfirmed: String?
    let dateModified: String?
    
}
