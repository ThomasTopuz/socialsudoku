//
//  SudokuView.swift
//  socialsudoku
//
//  Created by Thomas Topuz on 15.12.22.
//

import SwiftUI
import Firebase

struct SudokuView: View {
    @State var sudoku : [[Cell]]
    @State var showWonAlert: Bool = false
    @State var showWrongAlert: Bool = false
    @State var cellColor: Bool = false
    
    var body: some View {
        VStack{
            HStack{
                VStack {
                    Text("Sudoku").font(.title)
                    //Text(Auth.auth().currentUser != nil Auth.auth().currentUser.email! : "guest")
                }
            }
            Grid {
                for (0..<9) { row in
                    GridRow {
                        ForEach(0..<9) { c in
                            print("ciao")
                            
                            if sudoku[row][c].isInput {
                                TextField(" ", value: $sudoku[row][c].value, formatter: NumberFormatter()).keyboardType(.numberPad).font(.title).opacity(0.3)
                                    .frame(width:40, height:40, alignment: .center)
                                    .border(Color.black.opacity(0.7))
                                    .background(cellColor == true ? Color.yellow: Color.black).multilineTextAlignment(.center)
                            } else {
                                Text(String(sudoku[row][c].value)).font(.title).frame(width:40, height:40, alignment: .center)
                                    .border(Color.black)
                                    .background(cellColor == true ? Color.yellow: Color.black).multilineTextAlignment(.center)
                            }
                        }
                    }
                }.padding()
                
            }
                Spacer()
                Button("Submit") {
                    var hasWon = SudokuGenerator.validate(cells: sudoku)
                    if (hasWon) {
                        showWonAlert = true
                        
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
