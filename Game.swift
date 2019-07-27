//
//  Game.swift
//  Apple Pie
//
//  Created by Mikolaj Lukasik on 27/07/2019.
//  Copyright © 2019 Mikolaj Lukasik. All rights reserved.
//

import Foundation

struct Game {
    var word: String
    var incorrectMovesRemaining: Int
    var guessedLetters: [Character]
    
    mutating func playerGuessed(letter: Character) -> Bool {
        guessedLetters.append(letter)
        if !word.folding(options: .diacriticInsensitive, locale: .current).contains(letter) {
            incorrectMovesRemaining -= 1
            return false
        } else {
            return true
        }
    }
    
    var formattedWord: String {
        var guessedWord = ""
        for letter in word {
            let letterWithoutDiacritics = String(letter).folding(options: .diacriticInsensitive, locale: .current)
            if guessedLetters.contains(Character(letterWithoutDiacritics)) {
                guessedWord += "\(letter)"
            } else {
                guessedWord += "_"
            }
        }
        return guessedWord
    }
}
