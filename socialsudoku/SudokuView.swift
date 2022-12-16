//
//  SudokuView.swift
//  socialsudoku
//
//  Created by Thomas Topuz on 15.12.22.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct SudokuView: View {
    @State var sudoku : [[Cell]]
    @State var showWonAlert: Bool = false
    @State var showWrongAlert: Bool = false
    @State var cellColor: Bool = true
    @EnvironmentObject var leaderBoardService: LeaderboardService

    var body: some View {
        VStack{
            HStack{
                VStack {
                    Text("Sudoku").font(.title)
                    Text(Auth.auth().currentUser != nil ? Auth.auth().currentUser!.email! : "guest")
                }
            }
            Grid {
                ForEach (0..<9) { row in
                    GridRow {
                        ForEach(0..<9) { c in
                            if sudoku[row][c].isInput {
                                TextField(" ", value: $sudoku[row][c].value , formatter: NumberFormatter()).keyboardType(.numberPad).font(.title).opacity(0.3)
                                    .frame(width:30, height:30, alignment: .center)
                                    .border(Color.black.opacity(0.7))
                                    .background(cellColor == true ? Color.yellow: Color.black).multilineTextAlignment(.center).onReceive(NotificationCenter.default.publisher(for: UITextField.textDidBeginEditingNotification)) { obj in
                                        if let textField = obj.object as? UITextField {
                                            textField.selectedTextRange = textField.textRange(from: textField.beginningOfDocument, to: textField.endOfDocument)
                                        }
                                    }
                            } else {
                                Text(String(sudoku[row][c].value)).font(.title).frame(width:30, height:30, alignment: .center)
                                    .border(Color.black)
                                    .background(cellColor == true ? Color.yellow: Color.black).multilineTextAlignment(.center)
                            }
                        }
                    }
                }
                
            }
                Spacer()
                Button("Submit") {
                    var hasWon = SudokuGenerator.validate(cells: sudoku)
                    if (hasWon) {
                        showWonAlert = true
                        leaderBoardService.incrementUserScore(email:  Auth.auth().currentUser!.email! )
                        
                    } else {
                        showWrongAlert = true
                    }
                } .alert("You won", isPresented: $showWonAlert) {
                    Button("OK", role: .cancel) { }
                } .alert("Wrong answere", isPresented: $showWrongAlert) {
                    Button("Retry", role: .cancel) { }
                }
            }
        }
    }
    
    struct SudokuView_Previews: PreviewProvider {
        static var previews: some View {
            SudokuView(sudoku: SudokuGenerator.generateSudoku())
        }
    }
