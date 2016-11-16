//
//  ViewController.swift
//  Tic-Tac-Toe
//
//  Created by Kip Lawrence on 11/8/16.
//  Copyright © 2016 Kip Lawrence. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var messageToUser: UILabel!

    private let game = TicTacToeGame()
    @IBOutlet weak var testImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUIMessage()
        resetBoard()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func resetBoard() {
        game.reset()
        for buttonTag in 1...9 {
            let boardButton = self.view.viewWithTag(buttonTag) as? TicTacToeButton
            boardButton?.pieceShowing = .blank
        }
    }
    
    func updateUIMessage() {
        messageToUser.text = game.getMessageToShowInUI()
    }
    
    @IBAction func buttonClicked(_ boardButton: TicTacToeButton) {
        if game.isPlayerTurn() {
            if game.getPlayerSymbol() == "X" {
                boardButton.pieceShowing = .x
            } else {
                boardButton.pieceShowing = .o
            }
            game.playerTookTurn(boardPosition: boardButton.tag)
            updateUIMessage()
        } else if game.isFinished() {
            resetBoard()
            updateUIMessage()
        }
    }
    
}

