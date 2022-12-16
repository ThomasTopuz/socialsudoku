//
//  socialsudokuApp.swift
//  socialsudoku
//
//  Created by Thomas Topuz on 14.12.22.
//

import SwiftUI
import FirebaseCore
import FirebaseAuth
import Firebase
import GoogleSignIn

@main
struct socialsudokuApp: App {
    @StateObject private var sudoku = ModelData()
    @StateObject private var leaderboardService = LeaderboardService()
    
    init () {
        FirebaseApp.configure()
    }

    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView(sudoku: SudokuGenerator.generateSudoku()).environmentObject(leaderboardService)
                //LoginView(isLoggedIn: false)
            }
        }
    }
}
