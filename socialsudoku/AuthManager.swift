//
//  AuthManager.swift
//  socialsudoku
//
//  Created by Thomas Topuz on 15.12.22.
//

import Foundation
import FirebaseAuth

class AuthManager {
    func performSignIn (email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            guard let strongSelf = self else { return }
        }}
}
