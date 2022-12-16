//
//  LoginView.swift
//  socialsudoku
//
//  Created by Thomas Topuz on 15.12.22.
//

import SwiftUI
import FirebaseCore
import FirebaseAuth

struct LoginView: View {
    @State var email: String = ""
    @State var password: String = ""
    @State var loginError: Bool = false
    @Binding var isLoggedIn: Bool

    var body: some View {
        VStack {
            Spacer()
            Image("logo")
            Spacer()
            Text("Login").font(.title)
            TextField("Username", text: $email)
                .padding()             .textFieldStyle(.roundedBorder)
            
            SecureField("Password", text: $password).padding().textFieldStyle(.roundedBorder)
            Button("Login") {
                performLogin()
                print("HERE")

            }.padding(.bottom)
                .alert("Wrong email or password", isPresented: $loginError) {
                            Button("OK", role: .cancel) { }
                        }
            
            Button("Login With google") {
                performLogin()
            }
            Spacer()
        }.onAppear {
            Auth.auth().addStateDidChangeListener {auth, user in
                if user != nil {
                    isLoggedIn.toggle()
                }
            }
        }
    }
    
    func performLogin () {
        Auth.auth().signIn(withEmail: email, password:password) {
            result, error in if error != nil {
                print(error!.localizedDescription)
                loginError = true
            }
        }
        print("HERE")
        AuthManager().performSignIn(email:email, password: password)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(isLoggedIn: .constant(false))
    }
}
