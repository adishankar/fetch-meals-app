//
//  MealDetailView.swift
//  fetch-meals-app
//
//  Created by Adi Shankar on 6/26/23.
//

import SwiftUI

struct MealDetailView: View {
    
    let mealDetailViewModel: MealDetailViewModel
    
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    AsyncImage(url: URL(string: mealDetailViewModel.imageUrl)) { image in
                        image
                            .resizable()
                            .scaledToFill()
                    } placeholder: {
                        Image(systemName: "fork.knife")
                    }
                    .frame(maxWidth: .infinity, maxHeight: 200)
                    .cornerRadius(0)
                    Spacer()
                }
                HStack {
                    Text(mealDetailViewModel.mealName)
                        .font(.system(size: 36))
                        .bold()
                    Spacer()
                }
                HStack {
                    Text("Tags:")
                        .font(.headline)
                        .padding(.trailing, 4)
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(mealDetailViewModel.tags, id: \.self) { tag in
                                HStack {
                                    Text(tag)
                                        .lineLimit(1)
                                        .padding(8)
                                        .background(Color.yellow.opacity(0.1))
                                        .cornerRadius(10)
                                }
                            }
                        }
                    }
                    Spacer()
                }
                HStack {
                    Text("Ingredients")
                        .font(.title2)
                        .bold()
                    Spacer()
                }
                .padding(.top, 10)
                VStack {
                    ForEach(mealDetailViewModel.ingredients, id: \.ingredientName) { mealDetailIngredient in
                        HStack {
                            if let measurement = mealDetailIngredient.ingredientMeasurement {
                                let ingredientText = "\(mealDetailIngredient.ingredientName), \(measurement)"
                                Text(ingredientText)
                                    .font(.subheadline)
                            }
                            else {
                                let ingredientText = "\(mealDetailIngredient.ingredientName)"
                                Text(ingredientText)
                                    .font(.subheadline)
                            }
                            Spacer()
                        }
                    }
                }
                HStack {
                    Text("Instructions")
                        .font(.title2)
                        .bold()
                    Spacer()
                }
                .padding(.top, 10)
                VStack {
                    ForEach(0..<mealDetailViewModel.instructions.count, id: \.self) { i in
                        HStack {
                            let instructionText = "\(i+1). \(mealDetailViewModel.instructions[i])"
                            Text(instructionText)
                            Spacer()
                        }
                        .padding(.bottom, 4)
                        
                    }
                }
                .padding(2)
            }
        }
        .padding()
    }
}

//struct MealDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        MealDetailView()
//    }
//}
