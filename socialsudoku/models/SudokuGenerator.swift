//
//  SudokuGenerator.swift
//  socialsudoku
//
//  Created by Thomas Topuz on 14.12.22.
//

import Foundation
struct SudokuGenerator {
    var sudoku = [[Cell]]()
    static func generateSudoku () -> [[Cell]] {
        print("CIAO")
        var tab: [[Cell]] = []
        var arr = genEmpty()
        arr.shuffle()
        tab.append(arr)
        
        for row in 1..<9 {
            // Append an empty row.
            
            if (row%3==0) {
                var shifted = genEmpty()
                for o in 0..<9 {
                    shifted[(o+1)%9] = tab[row-1][o]
                }
                print(shifted)
                tab.append(shifted)
            }  else {
                
                tab.append(genEmpty())
                for col in 0..<9 {
                    // Populate the row.
                    tab[row][(col+6)%9] = tab[row-1][col]
                }
            }
        }
        for _ in 0...50 {
            var x = Int.random(in: 0..<9)
            var y = Int.random(in: 0..<9)
            tab[x][y].isInput = true
            tab[x][y].value = 0
            
        }
        
        return tab
    }
    static func genEmpty () -> [Cell]{
        var array = [Cell]()
        for i in 1..<10 {
            array.append( Cell(value: i, isInput: false))
        }
        return array
    }
    
    static func validate (cells: [[Cell]]) -> Bool {
        // a sudoku is valid if rows and cols have all non repeating numbers (easy check with)
        //@TODO transorm board to int array
        // check each row for duplicates in row
        
        var board:[[Int]] = []
        for i in 0 ... 8 {
            board.append(cells[i].map{Int($0.value)})
        }
        
        print(board)
        for i in 0 ... 9 {
            if (Array(Set((board[i]))).count != board[i].count ) {
                return false
            }
        }
        
        // check each column
        for i in 0 ... 8 {
            var column = [board[0][i], board[1][i], board[2][i], board[3][i], board[4][i], board[5][i], board[6][i], board[7][i], board[8][i]]
            if (Array(Set(column)).count != column.count ) {
                return false
            }
        }
        
        for i in stride(from: 0, to: 7, by: 3) {
            for j in stride(from: 0, to: 7, by: 3) {
                var array = [board[i][j], board[i][j+1], board[i][j+2],
                             board[i+1][j], board[i+1][j+1], board[i+1][j+2],
                             board[i+2][j], board[i][j+1], board[i+2][j+2]
                ]
                if (Array(Set(array)).count != array.count ) {
                    return false
                }
            }
        }
        return true
    }
}
