//
//  ContentView.swift
//  Guess The Flag
//
//  Created by Jaden Lee on 2023-06-06.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia","France", "Germany", "Ireland", "Italy", "Monaco", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correct = Int.random(in: 0...2)
    @State private var showScore : Bool = false
    @State private var check = ""
    @State private var score = 0
    
    var body: some View {
        ZStack{
            Color.gray
                .ignoresSafeArea()
            
            VStack {
                Text("Pick the country flag :")
                Text(countries[correct])
                
                
                ForEach(0..<3) { country in
                    Button{
                        tapped(country: country)
                    } label:{
                        Image(countries[country])
                    }
                }
            }
            .padding()
        }
        .alert(check,isPresented: $showScore) {
            Button("Continue") {askQuestion()}
        } message: {
            Text("Your score is \(score)")
        }
    }
    
    private func tapped (country : Int) {
        if country == correct {
            check = "Correct"
            score += 1
        } else {
            check = "Incorrect"
            score -= 1
        }
        showScore.toggle()
    }
    
    private func askQuestion (){
        countries.shuffle()
        correct = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
