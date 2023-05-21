//
//  APICalls.swift
//  MealPal
//
//  Created by Junaid Ahmed on 5/20/23.
//

// class to make both of our API calls, one for the full list of desserts, and one for individual dessert details

import Foundation

class APICalls {
    
    func fetchMeals(completion: @escaping ([Meal]?) -> Void) {
        let urlString = "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert"
        
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Error fetching meals: \(error)")
                completion(nil)
                return
            }
            
            guard let data = data else {
                completion(nil)
                return
            }
            
            do {
                let decodedResponse = try JSONDecoder().decode(MealListResponse.self, from: data)
                let meals = decodedResponse.meals
                // response is an array with these three properties
//                for meal in meals {
//                    print("Meal ID: \(meal.strMeal)")
//                    print("Meal Name: \(meal.idMeal)")
//                    print("Meal img: \(meal.strMealThumb)")
//                }
                completion(meals)
            } catch {
                print("Error decoding meal list response: \(error)")
                completion(nil)
            }
        }.resume()
    }
    func fetchMealDetails(with mealID: String, completion: @escaping (DetailedMeal?) -> Void) {
        let urlString = "https://themealdb.com/api/json/v1/1/lookup.php?i=\(mealID)"
        
        // endpoint for individual dessert
        print(urlString)
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Error fetching meal details: \(error)")
                completion(nil)
                return
            }
            
            guard let data = data else {
                completion(nil)
                return
            }
            
            do {
                let decodedResponse = try JSONDecoder().decode(MealDetailResponse.self, from: data)
                if let meal = decodedResponse.meals.first {
                    completion(meal)
                } else {
                    completion(nil)
                }
            } catch {
                print("Error decoding meal detail response: \(error)")
                completion(nil)
            }
        }.resume()
    }

}
