//
//  LeaderboardService.swift
//  socialsudoku
//
//  Created by Thomas Topuz on 15.12.22.
//

import Foundation
import Firebase
import FirebaseFirestore

class LeaderboardService : ObservableObject {
    @Published var scores: [Score] = []
    init() {
        fetchScores()
        incrementUserScore(email: "thomatop@gmail.com")
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
    
    func incrementUserScore(email: String) {
        print("email")
        let db = Firestore.firestore()
        let doc = db.collection("leaderboard").document("thomatop@gmail.com")
        doc.updateData(["score": FieldValue.increment(Int64(1))])
    }
}
