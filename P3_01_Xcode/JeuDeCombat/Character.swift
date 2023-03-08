//
//  Personnage.swift
//  JeuDeCombat
//
//  Created by Guillaume Bourlart on 17/09/2021.
//

import Foundation

class Character {
    
    // list containing each informations about character's type (for displaying)
    static var charactersList: [ (style: Character.Style, lifePoint: Int,defaultWeapon: String, power: Int, healing: Int)] =
    [(.tank, 1, "Shotgun", 80, 20),
     (.altruistic, 1,"Magic Powder", 30, 60),
     (.fighter, 1, "Assault rifle", 60, 10),
     (.wizard, 1, "Thanos glove", 80, 80)]

    enum Style: String {
        case tank = "Tank"
        case altruistic = "Altruistic"
        case wizard = "Wizard"
        case fighter = "Fighter"
        case none = "None"
    }
    
    // variables initialisation
    let name: String // character's name
    private var life: Int // character's life
    let style: Style // character's style
    private var weapon: Weapon // character's weapon
    
    
    init(name: String, life: Int, weapon: Weapon, style: Style){
        self.name = name
        self.life = life
        self.style = style
        self.weapon = weapon
    }
    
    // return current life
    func getLife() -> Int {
        return self.life
    }
    // return current weapon
    func getWeapon() -> Weapon {
        return self.weapon
    }
    // change currrent weapon
    func changeWeapon(weapon: Weapon){
        self.weapon = weapon
    }
    
    // return power of current weapon (for attacking)
    func inflictDamages() -> Int {
        return self.weapon.power
    }
    
    // receive damages
    func receiveDamages(damages: Int) {
        self.life -= damages
        if self.life < 0 {
            self.life = 0
        }
    }
    
    // return healing of weapon (when healing)
    func giveLifePoints() -> Int {
        return self.weapon.healing
    }
    
    // get heal by someone
    func receiveLifePoints(heal: Int) {
        self.life += heal
    }
    
    // return a random weapon
    func getRandomWeapon() -> Weapon?{
        return Weapon.weaponList.randomElement()
    }
    
   
    
    
}

class Tank: Character {
    
    init(name: String) {
        super.init(name: name, life: 1, weapon: Shotgun(), style: .tank)
    }
}

class Altruistic: Character {
    init(name: String) {
        super.init(name: name, life: 1, weapon: MagicPowder(), style: .altruistic)
    }
}

class Fighter: Character {
    init(name: String) {
        super.init(name: name, life: 1, weapon: AssaultRifle(), style: .fighter)
    }
}

class Wizard: Character {
    init(name: String) {
        super.init(name: name, life: 1, weapon: ThanosGlove(), style: .wizard)
    }
}




