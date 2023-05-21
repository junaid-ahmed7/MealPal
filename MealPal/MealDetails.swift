//
//  MealDetails.swift
//  MealPal
//
//  Created by Junaid Ahmed on 5/20/23.
//

import SwiftUI

// all required details for each individual dessert
struct DetailView: View {
    let meal: Meal
    @State private var mealDetails: DetailedMeal?
    let apiCalls = APICalls()
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                if let mealDetails = mealDetails {
                    Text("Details for \(mealDetails.strMeal)")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.vertical, 20)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color.blue)
                        .foregroundColor(Color.white)
                        .cornerRadius(10)
                        .padding(.horizontal, 20)
                    
                    Text("Instructions:")
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(.horizontal, 20)
                    
                    Text(mealDetails.strInstructions)
                        .font(.body)
                        .padding(.horizontal, 20)
                    
                    Text("Ingredients:")
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(.horizontal, 20)
                    VStack(alignment: .leading, spacing: 10) {
                        // only render if ingredient in response was populated, ignoring nulls and empty strings
                        ForEach(1...20, id: \.self) { index in
                            if let ingredient = mealDetails.value(forIngredientKey: "strIngredient\(index)"),
                               !ingredient.isEmpty,
                               let measure = mealDetails.value(forMeasureKey: "strMeasure\(index)") {
                                Text("\(ingredient), \(measure)")
                                    .font(.subheadline)
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                } else {
                    ProgressView()
                }
            }
            .padding(.top, 20)
        }
        .onAppear {
            fetchMealDetails(with: meal.idMeal)
        }
        .navigationTitle("Detail")
    }
    
    func fetchMealDetails(with mealId: String) {
        apiCalls.fetchMealDetails(with: mealId) { result in
            DispatchQueue.main.async {
                mealDetails = result
            }
        }
    }
}

// helper functions for list of ingredients and measurements, to allow dynamically rendering depending on how many received from endpoint
extension DetailedMeal {
    func value(forIngredientKey key: String) -> String? {
        let mirror = Mirror(reflecting: self)
        let property = mirror.children.first { $0.label == key }
        return property?.value as? String
    }
    
    func value(forMeasureKey key: String) -> String? {
        let mirror = Mirror(reflecting: self)
        let property = mirror.children.first { $0.label == key }
        return property?.value as? String
    }
}


