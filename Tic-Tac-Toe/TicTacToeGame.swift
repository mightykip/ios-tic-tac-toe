//
//  TicTacToeModel.swift
//  Tic-Tac-Toe
//
//  Created by Kip Lawrence on 11/10/16.
//  Copyright © 2016 Kip Lawrence. All rights reserved.
//

import Foundation

class TicTacToeGame {
    
    var currentGameState = GameState.playerOneTurn
    var boardState = [0, 0, 0, 0, 0, 0, 0, 0, 0]
    
    enum GameState {
        case playerOneTurn,
        playerOneWins,
        playerTwoTurn,
        playerTwoWins,
        stalemate
        
        func getMessageToShowInUI() -> String {
            switch self {
            case.playerOneTurn:
                return "X - Your Move!"
            case.playerOneWins:
                return "Player X Wins!"
            case.playerTwoTurn:
                return "O - Your Move!"
            case.playerTwoWins:
                return "Player O Wins!"
            case .stalemate:
                return "No One Wins!"
            }
        }
        
        func getPlayerSymbol() -> String {
            switch self {
            case.playerOneTurn:
                return "X"
            case.playerTwoTurn:
                return "O"
            default:
                return ""
            }
        }
        
        func getPlayerInt() -> Int {
            switch self {
            case.playerOneTurn:
                return 1
            case.playerTwoTurn:
                return 2
            default:
                return 0
            }
        }
        
    }
    
    func reset() {
        currentGameState = GameState.playerOneTurn
        boardState = [0, 0, 0, 0, 0, 0, 0, 0, 0]
    }
    
    func getMessageToShowInUI() -> String {
        return currentGameState.getMessageToShowInUI()
    }
    
    func getPlayerSymbol() -> String {
        return currentGameState.getPlayerSymbol()
    }
    
    func isPlayerTurn() -> Bool {
        return currentGameState == GameState.playerOneTurn || currentGameState == GameState.playerTwoTurn
    }
    
    func playerTookTurn(boardPosition: Int) {
        boardState[boardPosition - 1] = currentGameState.getPlayerInt()
        updateState()
    }

    func updateState() {
        if isOver() {
            if didPlayerOneWin() {
                currentGameState = GameState.playerOneWins
            } else if didPlayerTwoWin() {
                currentGameState = GameState.playerTwoWins
            } else {
                currentGameState = GameState.stalemate
            }
        } else {
            switch currentGameState {
            case.playerOneTurn:
                currentGameState = GameState.playerTwoTurn
            case.playerTwoTurn:
                currentGameState = GameState.playerOneTurn
            default:
                break
            }
        }
    }
    
    func isOver() -> Bool {
        return didPlayerOneWin() || didPlayerTwoWin() || isStalemate()
    }
    
    func isStalemate() -> Bool {
        var gameOver = true
        for index in 0...8 {
            if (boardState[index] == 0) {
                gameOver = false
            }
        }
        return gameOver
    }
    
    func didPlayerOneWin() -> Bool {
        return checkIfPlayerWins(player: 1)
    }
    
    func didPlayerTwoWin() -> Bool {
        return checkIfPlayerWins(player: 2)
    }
    
    func checkIfPlayerWins(player: Int) -> Bool {
        var wins = false
        if boardState[0] == player && boardState[1] == player && boardState[2] == player
            || boardState[3] == player && boardState[4] == player && boardState[5] == player
            || boardState[6] == player && boardState[7] == player && boardState[8] == player
            || boardState[0] == player && boardState[3] == player && boardState[6] == player
            || boardState[1] == player && boardState[4] == player && boardState[7] == player
            || boardState[2] == player && boardState[5] == player && boardState[8] == player
            || boardState[0] == player && boardState[4] == player && boardState[8] == player
            || boardState[2] == player && boardState[4] == player && boardState[6] == player
        {
            wins = true
        }
        return wins
    }

    func startGame() {
        currentGameState = GameState.playerOneTurn
    }
    
}
