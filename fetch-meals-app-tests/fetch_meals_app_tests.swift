//
//  fetch_meals_app_tests.swift
//  fetch-meals-app-tests
//
//  Created by Adi Shankar on 6/27/23.
//

import XCTest
@testable import fetch_meals_app

final class fetch_meals_app_tests: XCTestCase {

    let decoder = JSONDecoder()
    var mealsVC: MealsViewController!
    
    override func setUp() {
        super.setUp()
        mealsVC = MealsViewController()
    }
    
    /// Test retrieve all meals response mapping
    func testMealsResponse() {
        guard let data = getFileData("meals") else {
            return
        }
        
        let mealsResponse = try! decoder.decode(MealsResponse.self, from: data)
        let meals = mealsVC.toViewModel(mealsResponse)
        
        XCTAssertEqual(meals.count, 5)
    }
    
    /// Test retrieve meal detail rresponse mapping
    func testMealDetailResponse() {
        guard let data = getFileData("meal_detail_52891") else {
            return
        }
        
        let mealDetailResponse = try! decoder.decode(MealDetailResponse.self, from: data)
        guard let mealDetail = mealsVC.toViewModel(mealDetailResponse) else {
            return
        }
        
        XCTAssertEqual(mealDetail.mealId, "52891")
        XCTAssertEqual(mealDetail.mealName, "Blackberry Fool")
        XCTAssertEqual(mealDetail.tags.count, 4)
        XCTAssertEqual(mealDetail.ingredients.count, 12)
        mealDetail.ingredients.forEach { mealDetailIngredient in
            XCTAssertFalse(mealDetailIngredient.ingredientName.isEmpty)
        }
        XCTAssertEqual(mealDetail.instructions.count, 11)
    }
    
    private func getFileData(_ fileName: String) -> Data? {
        guard let path = Bundle.main.path(forResource: fileName, ofType: "json") else {
            return nil
        }
        let file = URL(filePath: path)
        return try? Data(contentsOf: file)
    }

}
