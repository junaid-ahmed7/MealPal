//
//  ContentView.swift
//  MealPal
//
//  Created by Junaid Ahmed on 5/17/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Color.blue.edgesIgnoringSafeArea(.all) // Set the background color to gray
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
            }
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
