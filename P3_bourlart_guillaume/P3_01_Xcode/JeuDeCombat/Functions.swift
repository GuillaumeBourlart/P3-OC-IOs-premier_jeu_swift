//
//  Fonctions.swift
//  JeuDeCombat
//
//  Created by Guillaume Bourlart on 17/09/2021.
//

import Foundation


//verify if user input is empty
func isEmpty(userInput: String?) -> Bool {
    //return !(optionnel?.isEmpty ?? true)
    guard let value = userInput else {
        return true
    }
    return value.isEmpty
    
}






//verify if user input is in chosen range
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
    
    


