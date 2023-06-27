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
                    .cornerRadius(20)
                    Spacer()
                }
                HStack {
                    Text(mealDetailViewModel.mealName)
                        .font(.system(size: 36))
                        .bold()
                    Spacer()
                }
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
