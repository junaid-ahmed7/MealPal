//
//  MealListView.swift
//  MealPal
//
//  Created by Junaid Ahmed on 5/20/23.
//

import SwiftUI

struct MealListView: View {
    let meals: [Meal]

    var body: some View {
        // generate list, with images of all deserts received from the endpoint
        List(meals, id: \.idMeal) { meal in
            NavigationLink(destination: DetailView(meal: meal)) {
                HStack(spacing: 10) {
                    AsyncImage(url: URL(string: meal.strMealThumb)) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 50, height: 50)
                            .cornerRadius(8)
                    } placeholder: {
                        // placeholder view while the image is being fetched
                        ProgressView()
                    }

                    VStack(alignment: .leading, spacing: 5) {
                        Text(meal.strMeal)
                            .font(.headline)
                        Text(meal.idMeal)
                            .font(.body)
                            .foregroundColor(.gray)
                    }
                }
            }
        }
        .navigationTitle("Meals")
    }
}
