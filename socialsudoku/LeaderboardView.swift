//
//  LeaderboardView.swift
//  socialsudoku
//
//  Created by Thomas Topuz on 15.12.22.
//

import SwiftUI

struct LeaderboardView: View {
    @EnvironmentObject var leaderBoardService: LeaderboardService
    
    var body: some View {
        NavigationView {
            List (leaderBoardService.scores, id: \.email) {
                score in
                HStack {
                    Text(score.email)
                    Spacer()
                    Text(String(score.score))

                }
              
            }
        }
    }
}

struct LeaderboardView_Previews: PreviewProvider {
    static var previews: some View {
        LeaderboardView()
    }
}
