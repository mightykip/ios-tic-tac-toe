//
//  TicTacToeModel.swift
//  Tic-Tac-Toe
//
//  Created by Kip Lawrence on 11/10/16.
//  Copyright © 2016 Kip Lawrence. All rights reserved.
//

import Foundation

class TicTacToeGame {
    
    private static let EmptyGameBoard = [ 0, 0, 0,
                                          0, 0, 0,
                                          0, 0, 0 ]
    
    private static let GameStateData: [GameState: [String]] = [
        .playerOneTurn: ["X - Your Move!", "X", "1"],
        .playerTwoTurn: ["O - Your Move!", "O", "2"],
        .playerOneWins: ["Player X Wins!", "", ""],
        .playerTwoWins: ["Player O Wins!", "", ""],
        .stalemate: ["No One Wins!", "", ""]
    ]
    
    private var gameState = GameState.playerOneTurn
    private var gameBoard = EmptyGameBoard
    
    private enum GameState {
        case playerOneTurn
        case playerOneWins
        case playerTwoTurn
        case playerTwoWins
        case stalemate
        
        func getMessageToShowInUI() -> String {
            return TicTacToeGame.GameStateData[self]![0]
        }
        
        func getPlayerSymbol() -> String {
            return TicTacToeGame.GameStateData[self]![1]
        }
        
        func getPlayerInt() -> Int {
            return Int(TicTacToeGame.GameStateData[self]![2])!
        }
        
    }
    
    func reset() {
        gameState = GameState.playerOneTurn
        gameBoard = TicTacToeGame.EmptyGameBoard
    }
    
    func getMessageToShowInUI() -> String {
        return gameState.getMessageToShowInUI()
    }
    
    func getPlayerSymbol() -> String {
        return gameState.getPlayerSymbol()
    }
    
    func isPlayerTurn() -> Bool {
        return gameState == .playerOneTurn || gameState == .playerTwoTurn
    }
    
    func playerTookTurn(boardPosition: Int) {
        gameBoard[boardPosition - 1] = gameState.getPlayerInt()
        updateGameState()
    }

    private func updateGameState() {
        if isFinished() {
            if didPlayerOneWin() {
                gameState = .playerOneWins
            } else if didPlayerTwoWin() {
                gameState = .playerTwoWins
            } else {
                gameState = .stalemate
            }
        } else {
            switch gameState {
            case .playerOneTurn:
                gameState = .playerTwoTurn
            case .playerTwoTurn:
                gameState = .playerOneTurn
            default:
                break
            }
        }
    }
    
    func isFinished() -> Bool {
        return didPlayerOneWin() || didPlayerTwoWin() || isStalemate()
    }
    
    private func didPlayerOneWin() -> Bool {
        return checkIfPlayerWins(player: 1)
    }
    
    private func didPlayerTwoWin() -> Bool {
        return checkIfPlayerWins(player: 2)
    }

    private func checkIfPlayerWins(player: Int) -> Bool {
        var wins = false
        if gameBoard[0] == player && gameBoard[1] == player && gameBoard[2] == player
            || gameBoard[3] == player && gameBoard[4] == player && gameBoard[5] == player
            || gameBoard[6] == player && gameBoard[7] == player && gameBoard[8] == player
            || gameBoard[0] == player && gameBoard[3] == player && gameBoard[6] == player
            || gameBoard[1] == player && gameBoard[4] == player && gameBoard[7] == player
            || gameBoard[2] == player && gameBoard[5] == player && gameBoard[8] == player
            || gameBoard[0] == player && gameBoard[4] == player && gameBoard[8] == player
            || gameBoard[2] == player && gameBoard[4] == player && gameBoard[6] == player
        {
            wins = true
        }
        return wins
    }

    private func isStalemate() -> Bool {
        var gameOver = true
        for index in 0...8 {
            if (gameBoard[index] == 0) {
                gameOver = false
            }
        }
        return gameOver
    }
    
}
