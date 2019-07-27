//
//  ViewController.swift
//  Apple Pie
//
//  Created by Mikolaj Lukasik on 26/07/2019.
//  Copyright © 2019 Mikolaj Lukasik. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var listOfWords:[String] = ["pokémon", "buccaneer", "swift", "glorious", "incandescent", "bug", "program"]
    let incorrectMovesAllowed = 7
    var totalWins = 0 {
        didSet {
            newRound()
        }
    }
    var totalLosses = 0 {
        didSet {
            newRound()
        }
    }
    var points = 0
    var currentGame: Game!
    
    @IBOutlet var treeImageView: UIImageView!
    @IBOutlet var correctWordLabel: UILabel!
    @IBOutlet var scoreLabel: UILabel!
    @IBOutlet var pointsLabel: UILabel!
    @IBOutlet var letterButtons: [UIButton]!
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        sender.isEnabled = false
        let letterString = sender.title(for: .normal)!
        let letter = Character(letterString.lowercased())
        let goodGuess = currentGame.playerGuessed(letter: letter)
        if goodGuess {
            points += 1
        } else {
            points -= 1
        }
        updateGameState()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        newRound()
    }

    func newRound(){
        if !listOfWords.isEmpty {
            let newWord = listOfWords.removeFirst()
            currentGame = Game(word: newWord, incorrectMovesRemaining: incorrectMovesAllowed, guessedLetters: [])
            enableLetterButtons(true)
            updateUI()
        } else {
            enableLetterButtons(false)
            updateUI()
            
        }
        
    }
    
    func updateUI() {
        let letters = currentGame.formattedWord.map {
            String($0).uppercased()
        }
        let wordWithSpacing = letters.joined(separator: " ")
        correctWordLabel.text = wordWithSpacing
        scoreLabel.text = "Wins: \(totalWins), Losses: \(totalLosses)"
        treeImageView.image = UIImage(named: "Tree \(currentGame.incorrectMovesRemaining)")
        pointsLabel.text = "Points:\n\(points)"
        
    }
    
    func updateGameState() {
        if currentGame.incorrectMovesRemaining == 0 {
            points -= 10
            totalLosses += 1
        } else if currentGame.word == currentGame.formattedWord {
            points += 10
            totalWins += 1
        } else {
            updateUI()
        }
    }
    
    func enableLetterButtons(_ enable: Bool) {
        for button in letterButtons {
            button.isEnabled = enable
        }
    }

}

