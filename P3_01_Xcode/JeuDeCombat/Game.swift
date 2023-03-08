//
//  File.swift
//  JeuDeCombat
//
//  Created by Guillaume Bourlart on 19/10/2021.
//

import Foundation


class Game {
    
    // inputStatus is used in "isValidInput" method when player choose the player he want to use
    enum inputStatus: String {case notAnInt = "Choose a number between 1 and 3", notInRange, characterIsDead = "This on is dead, sorry ! Choose an other character", changeAnswer = "Choose a new one then", everythingOk  }
    
    // variables initialisation
    let title: String // game title
    let playersMax: Int // maximum number of players in the game
    var playersList = [Player]() // list containing all players
    

    init(title: String, nbPlayer: Int){
        self.title = title
        self.playersMax = nbPlayer
    }
    
    
    
    // creation of players
    func createPlayers() {
        for i in 1...self.playersMax{
            print("Hello player \(i), choose a username")
            var answer = readLine()
            while isEmpty(userInput: answer) == true || usernameAlreadyExist(username: answer) == true{
                
                if isEmpty(userInput: answer) == true {
                    print("choose a valid username")
                    answer = readLine()
                }else {
                    print("This one already exist, choose an other one")
                    answer = readLine()
                }
            }
            let player = Player(username: answer!)
            playersList.append(player)
        }
    }
    
    // display of the characters list
    func displayCharacters() {
        let list = Player.getAllCharactersType()
        var i = 0
        for character in list {
            i = i+1
            print("\(i) \(character.style.rawValue): life -> \(character.lifePoint)    weapon -> \(character.defaultWeapon) (power: \(character.power)   heal: \(character.healing)   style: \(character.style.rawValue))")
        }
    }
    
    // selection of 3 fighters for each players
    func selectFighters() {
        
        for currentPlayer in playersList {
            
            while currentPlayer.maxCharactersReached() == false {
                // sentence's dispplay
                print("\(currentPlayer.username), choose your fighter number \(currentPlayer.getOwnedCharactersListCount())")
                
                // display of character's list
                displayCharacters()
            
                // fighter selection
                var choice = readLine()
                while getInt(userInput: choice) == nil || isInRange(userInput: choice, begin: 1, end: 4) == false{
                    print("Please, choose a number between 1 and 4")
                    choice = readLine()
                }
                let choiceInt = getInt(userInput: choice)!
                // choice of character's name
                print("Choose a name for your fighter !")
                var name = readLine()
                while isEmpty(userInput: name) == true || fighterNameAlreadyExist(fighterName: name)   {
                    print("This name is invalid are already took")
                    name = readLine()
                }
                let index = choiceInt - 1
                if currentPlayer.createCharacter(index: index, name: name) == false {
                    print("invalid choice")
                }
            }
        }
    }
    
    func gamePrompt() {
        
        // begin of the game
        for player in playersList {
            Swift.print("\(player.username), your characters are \(player.getCharacterAtIndex(index: 0).name), \(player.getCharacterAtIndex(index: 1).name) and \(player.getCharacterAtIndex(index: 2).name)")
        }
        
        print("The game can begin \n")

        var nbRound = 0 // number of round
        var currentPlayer = playersList[0] // player whose turn it is
        var otherPlayer = playersList[1] // other player
        
        // keep playing while current player didn't lose
        while currentPlayer.isStillAlive() {
            
            // Display the life of each character
            for player in playersList{
                print("\(player.username):  (1) \(player.getCharacterAtIndex(index: 0).name) : life -> \(player.getCharacterAtIndex(index: 0).getLife())   weapon -> \(player.getCharacterAtIndex(index: 0).getWeapon().name) (power: \(player.getCharacterAtIndex(index: 0).getWeapon().power)   heal: \(player.getCharacterAtIndex(index: 0).getWeapon().healing)   type: \(player.getCharacterAtIndex(index: 0).getWeapon().style)) \n     (2) \(player.getCharacterAtIndex(index: 1).name) :  life -> \(player.getCharacterAtIndex(index: 1).getLife())   weapon -> \(player.getCharacterAtIndex(index: 1).getWeapon().name) (power: \(player.getCharacterAtIndex(index: 1).getWeapon().power)   heal: \(player.getCharacterAtIndex(index: 1).getWeapon().healing)   type: \(player.getCharacterAtIndex(index: 0).getWeapon().style)) \n     (3) \(player.getCharacterAtIndex(index: 2).name) :  life -> \(player.getCharacterAtIndex(index: 2).getLife())   weapon -> \(player.getCharacterAtIndex(index: 2).getWeapon().name)  (power: \(player.getCharacterAtIndex(index: 2).getWeapon().power)   heal: \(player.getCharacterAtIndex(index: 2).getWeapon().healing)   type: \(player.getCharacterAtIndex(index: 0).getWeapon().style)) \n")
            }
            
            // ask current player if he wants to heal or attack
            print("\(currentPlayer.username), do you want to heal(1) or attack(2) ?")
            var answer = readLine()
            while getInt(userInput: answer) == nil || isInRange(userInput: answer, begin: 1, end: 2) == false {
                Swift.print("Please, choose a number between 1 and 2")
                answer = readLine()
            }
            
            // heal
            if Int(answer!) == 1 {
                
                Swift.print("\(currentPlayer.username), what fighter do you want to use ?")
                // Display of names and number of player's characters
                displayOwnedCharacters(player: currentPlayer)
                
                // healer selection
                let fighter = inputVerification(element: readLine(), targetPlayer: currentPlayer)
                let heal = currentPlayer.getCharacterAtIndex(index: fighter-1).giveLifePoints()
                
                Swift.print("\(currentPlayer.username), which player do you want to heal ?")
                // Display of names and number of player's characters
                displayOwnedCharacters(player: currentPlayer)
                
                // target selection
                let target = inputVerification(element: readLine(), targetPlayer: currentPlayer)
                currentPlayer.getCharacterAtIndex(index: target-1).receiveLifePoints(heal: heal)
                
                // get the character who did the action and call the random weapon function
                let targetCharacter = currentPlayer.getCharacterAtIndex(index: fighter-1)
                isMoreThan50percentChanceToHappen(targetCharacter: targetCharacter)
            }
            
            // attack
            else{
                
                Swift.print("\(currentPlayer.username), what fighter do you want to use  ?")
                // Display of names and number of player's characters
                displayOwnedCharacters(player: currentPlayer)
                
                // Attacker selection
                let fighter = inputVerification(element: readLine(), targetPlayer: currentPlayer)
                let damages = currentPlayer.getCharacterAtIndex(index: fighter-1).inflictDamages()
                
                Swift.print("\(currentPlayer.username), what fighter do you want to attack ?")
                // Display of names and number of player's characters
                displayOwnedCharacters(player: otherPlayer)
                
                // target selection
                let target = inputVerification(element: readLine(), targetPlayer: otherPlayer)
                otherPlayer.getCharacterAtIndex(index: target-1).receiveDamages(damages: damages)
                
                // get the character who did the action and call the random weapon function
                let targetCharacter = currentPlayer.getCharacterAtIndex(index: fighter-1)
                isMoreThan50percentChanceToHappen(targetCharacter: targetCharacter)
            }
                
            
            // swiping players
            let temp = currentPlayer
            currentPlayer = otherPlayer
            otherPlayer = temp
                
            // round incrementation
            nbRound += 1
            
            print("End of round")
            
        }
        
        // Display the life of each character
        for player in playersList{
            print("\(player.username):  (1) \(player.getCharacterAtIndex(index: 0).name) : life -> \(player.getCharacterAtIndex(index: 0).getLife())   weapon -> \(player.getCharacterAtIndex(index: 0).getWeapon().name) (power: \(player.getCharacterAtIndex(index: 0).getWeapon().power)   heal: \(player.getCharacterAtIndex(index: 0).getWeapon().healing)   type: \(player.getCharacterAtIndex(index: 0).getWeapon().style)) \n     (2) \(player.getCharacterAtIndex(index: 1).name) :  life -> \(player.getCharacterAtIndex(index: 1).getLife())   weapon -> \(player.getCharacterAtIndex(index: 1).getWeapon().name) (power: \(player.getCharacterAtIndex(index: 1).getWeapon().power)   heal: \(player.getCharacterAtIndex(index: 1).getWeapon().healing)   type: \(player.getCharacterAtIndex(index: 0).getWeapon().style)) \n     (3) \(player.getCharacterAtIndex(index: 2).name) :  life -> \(player.getCharacterAtIndex(index: 2).getLife())   weapon -> \(player.getCharacterAtIndex(index: 2).getWeapon().name)  (power: \(player.getCharacterAtIndex(index: 2).getWeapon().power)   heal: \(player.getCharacterAtIndex(index: 2).getWeapon().healing)   type: \(player.getCharacterAtIndex(index: 0).getWeapon().style)) \n")
        }
        
        print("The winner is \(otherPlayer.username)")
        print("number of rounds: \(nbRound)")
    }
    
    
    // user input verification
    func inputVerification(element: String?, targetPlayer: Player) -> Int {
        var newValue = element
        var validate: String? = "y"
        
        repeat {
            if  isInputValid(newValue: newValue, targetPlayer: targetPlayer, validate: validate) == .notAnInt ||
                    isInputValid(newValue: newValue, targetPlayer: targetPlayer, validate: validate) == .notInRange {
                
                print("\(inputStatus.notAnInt.rawValue)")
                newValue = readLine()
                
            }else if isInputValid(newValue: newValue, targetPlayer: targetPlayer, validate: validate) == .characterIsDead {
                
                print("\(inputStatus.characterIsDead.rawValue)")
                newValue = readLine()
                
            }else if  isInputValid(newValue: newValue, targetPlayer: targetPlayer, validate: validate) == .changeAnswer {
                
                print("\(inputStatus.changeAnswer.rawValue)")
                newValue = readLine()
            }
            
            print("You chose \(targetPlayer.getCharacterAtIndex(index: getInt(userInput: newValue!)!-1).name) (character number \(newValue!)) are you sure ? (y/n)")
            validate = readLine()
            while validate != "y" && validate != "n" {
                print("chose 'y' or 'n' ")
                validate = readLine()
            }
            
        } while  isInputValid(newValue: newValue, targetPlayer: targetPlayer, validate: validate) != .everythingOk
        
        let newInt = getInt(userInput: newValue)
        return newInt!
        
    }
    
    func isInputValid(newValue: String?, targetPlayer: Player, validate: String?) -> inputStatus {
        
        if let IntValue = getInt(userInput: newValue) {
            if isInRange(userInput: newValue, begin: 1, end: 3) {
                if targetPlayer.isCharacterDead(characterNumber: IntValue) == false {
                    if validate == "y" {
                        return .everythingOk
                    }else{
                        return .changeAnswer
                    }
                }else{
                    return .characterIsDead
                }
            }else{
                return .notInRange
            }
        }else{
            return .notAnInt
        }
    }
    
    // verify if username already exist
    func usernameAlreadyExist(username: String?) -> Bool {
        
        for player in playersList{
            if player.username == username{
                return true
            }
        }
        return false
        
    }
    
    func fighterNameAlreadyExist(fighterName: String?) -> Bool{
        for player in playersList {
            for character in player.getOwnedCharacters(){
                if character.name == fighterName{
                    return true
                }
            }
        }
        return false
    }
    
    // 50% of chances that the character find a new weapon
    func isMoreThan50percentChanceToHappen(targetCharacter: Character) {
        let number = Int.random(in: 0...100)
        if number > 50, let randomWeapon = targetCharacter.getRandomWeapon()  {
            
            print("You found weapon : name -> \(randomWeapon.name)  damage -> \(randomWeapon.power)  heal -> \(randomWeapon.healing)     type -> \(randomWeapon.style.rawValue)")
            print("do you want to swipe it with you current weapon ?(y/n)")
            var answer = readLine()
            while answer != "y" && answer != "n" {
                print("choose y or n !")
                answer = readLine()
            }
            
            if answer == "y" {
                targetCharacter.changeWeapon(weapon: randomWeapon)
            }
            
        }
    }
    
    func displayOwnedCharacters(player: Player){
        let list = player.getOwnedCharacters()
        var i = 0
        for characters in list {
            i=i+1
            print("\(i) : \(characters.name)")
        }
    }
    
    // verify if user input is an Int
    func getInt(userInput: String?) -> Int? {
        if let userInput = userInput,
            let input = Int(userInput) {
                return input
            }else{
                return nil
            }
    }
    
    
    
    // verify if user input is empty
    func isEmpty(userInput: String?) -> Bool {
        //return !(optionnel?.isEmpty ?? true)
        guard let value = userInput else {
            return true
        }
        return value.isEmpty
        
    }
    
    // verify if user input is in chosen range
    func isInRange(userInput: String?, begin: Int, end: Int) -> Bool {
        if let userInput = getInt(userInput: userInput){
            if userInput >= begin && userInput <= end{
                return true
            }else{
                return false
            }
        }
        else{
            return false
        }
    }
    
    
}
