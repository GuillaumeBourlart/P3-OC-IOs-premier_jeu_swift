//
//  Arme.swift
//  JeuDeCombat
//
//  Created by Guillaume Bourlart on 17/09/2021.
//

import Foundation

class Weapon {
    // list containing all weapons type
    static let weaponList: [Weapon] = [Hand(), Shotgun(), AssaultRifle(), MagicWand(), ThanosGlove(), MagicPowder()]
    
    let name: String // weapon's name
    let power: Int // weapon's power
    let healing: Int // weapon's healing ability
    let style: Character.Style // weapon Style
    
    init(name: String, power: Int, healing: Int, style: Character.Style ) {
        self.name = name
        self.power = power
        self.healing = healing
        self.style = style
    }
}

class Hand: Weapon {
    init() {
        super.init(name: "Hand", power: 15, healing: 5, style: .none)
    }
}

class Shotgun: Weapon {
    
    init() {
        super.init(name: "Shotgun", power: 50, healing: 10, style: .tank)
    }
}
class AssaultRifle: Weapon {
    init() {
        super.init(name: "Assault rifle", power: 80, healing: 10, style: Character.Style.fighter)
    }
}
class MagicWand: Weapon {
    init() {
        super.init(name: "Magic wand", power: 40, healing: 10, style: Character.Style.wizard)
    }
}
class ThanosGlove: Weapon {
    init() {
        super.init(name: "Tanos glove", power: 90, healing: 10, style: Character.Style.wizard)
    }
}
class MagicPowder: Weapon {
    init() {
        super.init(name: "Magic powder", power: 10, healing: 10, style: Character.Style.altruistic)
    }
}
