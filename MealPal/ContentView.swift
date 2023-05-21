//
//  ContentView.swift
//  MealPal
//
//  Created by Junaid Ahmed on 5/17/23.
//

import SwiftUI

struct ContentView: View {
    let apiCalls = APICalls()
    
    @State private var meals: [Meal]?
    @State private var showMealList = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.blue.edgesIgnoringSafeArea(.all)
                VStack {
                    Image("Logo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .imageScale(.large)
                        .foregroundColor(.accentColor)
                        .cornerRadius(180)
                    Text("Hungry for dessert?")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                    
                    Button(action: {
                        fetchMeals()
                    }) {
                        Text("Get Dessert Ideas")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    
                    if let meals = meals {
                        // depracated in ios16, use alternative later
                        NavigationLink(destination: MealListView(meals: meals), isActive: $showMealList) {
                            EmptyView()
                        }
                    }
                }
                .padding()
            }
        }
    }
    // function runs when button clicked, makes api call to get desserts
    func fetchMeals() {
        apiCalls.fetchMeals { meals in
            if let meals = meals {
                self.meals = meals
                self.showMealList = true // activate the NavigationLink
            } else {
                // handle the case where fetching meals failed
                print("Failed to fetch meals")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
