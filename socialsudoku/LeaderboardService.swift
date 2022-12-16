//
//  LeaderboardService.swift
//  socialsudoku
//
//  Created by Thomas Topuz on 15.12.22.
//

import Foundation
import Firebase

class LeaderboardService : ObservableObject {
    @Published var scores: [Score] = []
    init() {
        fetchScores()
    }
    func fetchScores () {
        scores.removeAll()
        let db = Firestore.firestore()
        let ref = db.collection("leaderboard")
        ref.getDocuments {
            snapshot, error in guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            
            if let snapshot = snapshot {
                for document in snapshot.documents {
                    let data = document.data()
                    let email = data["email"] as? String ?? ""
                    let score = data["score"] as? Int ?? 0
                    let s = Score(email: email, score: score)
                    self.scores.append(s)
                }
            }
        }
    }
}
