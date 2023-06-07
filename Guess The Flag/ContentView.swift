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
    @State private var totalAnswered = 0
    @State private var gameOver = false
    
    var body: some View {
        ZStack{
            Color.gray
                .ignoresSafeArea()
            
            VStack {
                Text("Question #\(totalAnswered)")
                Text("Pick the country flag :")
                Text(countries[correct])
                
                
                ForEach(0..<3) { country in
                    Button{
                        tapped(country: country)
                        gameTrack()
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
        .alert("Game over!",isPresented: $gameOver) {
            Button("Reset") {
                score = 0
                totalAnswered = 0
            }
        }
    }
    
    private func tapped (country : Int) {
        if country == correct {
            check = "Correct!"
            score += 1
        } else {
            check = "Incorrect. This is a flag of \(countries[correct])"
            score -= 1
        }
        showScore.toggle()
        
    }
    
    private func askQuestion (){
        countries.shuffle()
        correct = Int.random(in: 0...2)
    }
    
    private func gameTrack (){
        self.totalAnswered += 1
        if totalAnswered == 8 {
            self.gameOver.toggle()
            print("game over")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
