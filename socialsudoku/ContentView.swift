//
//  ContentView.swift
//  socialsudoku
//
//  Created by Thomas Topuz on 14.12.22.
//

import Swift
import SwiftUI
import Combine

struct ContentView: View {
    @State var sudoku : [[Cell]]
    @State var isLoggedIn: Bool = false
    var body: some View {
        if (isLoggedIn) {
            TabView {
                SudokuView(sudoku: sudoku)
                    .tabItem {
                        Image(systemName: "heart.fill")
                        Text("Game")
                        
                    }
                LeaderboardView()
                    .tabItem {
                        Image(systemName: "person.fill")
                        Text("Leaderboard")
                    }
            }
        } else {
            LoginView(isLoggedIn: $isLoggedIn)
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(sudoku: SudokuGenerator.generateSudoku())
    }
}
