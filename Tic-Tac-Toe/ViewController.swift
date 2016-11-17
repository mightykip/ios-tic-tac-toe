//
//  ViewController.swift
//  Tic-Tac-Toe
//
//  Created by Kip Lawrence on 11/8/16.
//  Copyright © 2016 Kip Lawrence. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    @IBOutlet weak var messageToUser: UILabel!

    private let game = TicTacToeGame()
    private var games = [NSManagedObject]()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadGames()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        updateUIMessage()
        resetBoard()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    private func loadGames() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Games")
        do {
            let results =
                try managedContext.fetch(fetchRequest)
            games = results as! [NSManagedObject]
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
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
        if game.isPlayerTurn() && boardButton.pieceShowing == .blank {
            if game.getPlayerSymbol() == "X" {
                boardButton.pieceShowing = .x
            } else {
                boardButton.pieceShowing = .o
            }
            game.playerTookTurn(boardPosition: boardButton.tag)
            if game.isFinished() {
                if (game.didPlayerWin()) {
                    saveGame(player: Int16(game.getPlayerInt()), winner: game.didPlayerWin())
                }
                showGameOverMessage()
            } else {
                updateUIMessage()
            }
        }
    }
    
    private func showGameOverMessage() {
        var message = self.game.getMessageToShowInUI()
        message.append("\n\n")
        message.append("Total games played: ")
        message.append(String(self.games.count))
        message.append("\n")
        message.append("Number of X wins: ")
        message.append(String(self.numberOfWins(playerInt: 1)))
        message.append("\n")
        message.append("Number of O wins: ")
        message.append(String(self.numberOfWins(playerInt: 2)))
        let alert = UIAlertController(title: "Game Over",
                                      message: message,
                                      preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "Play Again?",
                                       style: .default,
                                       handler: { (action:UIAlertAction) -> Void in
                                        self.resetBoard()
                                        self.updateUIMessage()
        })
        alert.addAction(saveAction)
        present(alert,
                animated: true,
                completion: nil)
    }
    
    private func numberOfWins(playerInt: Int) -> Int {
        var wins = 0;
        for game in games as! [Games] {
            if game.player == Int16(playerInt) && game.winner {
                wins = wins + 1
            }
        }
        return wins
    }
    
    private func saveGame(player: Int16, winner: Bool) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity =  NSEntityDescription.entity(forEntityName: "Games",
                                                 in:managedContext)
        let game = NSManagedObject(entity: entity!,
                                     insertInto: managedContext)
        game.setValue(player, forKey: "player")
        game.setValue(winner, forKey: "winner")
        do {
            try managedContext.save()
            games.append(game)
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
    }
    
}

