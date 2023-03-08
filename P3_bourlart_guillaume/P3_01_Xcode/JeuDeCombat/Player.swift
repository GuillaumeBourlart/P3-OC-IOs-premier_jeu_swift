//
//  Joueur.swift
//  JeuDeCombat
//
//  Created by Guillaume Bourlart on 17/09/2021.
//

import Foundation

class Player {
    
    // variables initialisation
    let username: String // player's username
    static let charactersMax = 3 // maximum number of charcters by player
    private var ownedCharacter = [Character]() // list containing owned characters
    
    init(username: String){
        self.username = username
    }
    
    
    // return if player is dead or not
    func isStillAlive() -> Bool {
        // verify if current player has character's alive left
        var life: Int = 0
        for character in self.ownedCharacter {
            life += character.getLife()
        }
        if life <= 0 {
            return false
        }else{
            return true
        }
    }
    
    // return if chosen character is dead or not
    func isCharacterDead(characterNumber: Int) -> Bool {
            let character = getCharacterAtIndex(index: characterNumber-1)
            if character.getLife() <= 0 {
                return true
            }else {
                return false
            }
        }
    
    // return all characters type for displaying
    static func getAllCharactersType() -> Array<(style: Character.Style, lifePoint: Int,defaultWeapon: String, power: Int, healing: Int)> {
        return Character.charactersList
    }
    
    // return if maximum of player in the team (charactersMax) have been reached
    func maxCharactersReached() -> Bool {
        if ownedCharacter.count < Player.charactersMax {
            return false
        }else {
            return true
        }
    }
    
    // create a new character and add it to the team (ownedCharacter)
    func createCharacter(index: Int, name: String?) -> Bool {
        let character: Character
        switch index {
        case 0: character = Tank(name: name!)
            addCharacter(character: character)
            return true
        case 1: character = Altruistic(name: name!)
            addCharacter(character: character)
            return true
        case 2: character = Wizard(name: name!)
            addCharacter(character: character)
            return true
        case 3: character = Fighter(name: name!)
            addCharacter(character: character)
            return true
        default: return false
       }
        
        
    }
    // add the received character to the team (ownedCharacter)
    func addCharacter(character: Character) {
        ownedCharacter.append(character)
    }
    // get number of player in the team (ownedCharacter)
    func getOwnedCharactersListCount() -> Int{
        return ownedCharacter.count + 1
    }
    // return character which is at the chosen index
    func getCharacterAtIndex(index: Int) -> Character {
        return ownedCharacter[index]
    }
    
    func getOwnedCharacters() -> [Character] {
        return ownedCharacter
    }
        
    }

