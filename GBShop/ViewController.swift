//
//  ViewController.swift
//  GBShop
//
//  Created by Karahanyan Levon on 26.08.2021.
//

import UIKit
import Swinject

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

//        let container = Container()
        
//        container.register(Pet.self) { _ in Cat(name: "Барсик") }
//        container.register(PetOwner.self) { r in
//            PetOwner(pet: r.resolve(Pet.self)!)
//        }
//
//        let pet = container.resolve(Pet.self)!
//        let petOwner = container.resolve(PetOwner.self)!
//        print(pet.info())
//        print(petOwner.infoPet())
//
//        let h = container.resolve(String.self)
//        print(h)
    }
}

protocol Pet {
    func info() -> String
}


class Cat: Pet {
    let name: String

    init(name: String) {
        self.name = name
    }

    func info() -> String {
        return "Кот по имени - \(name)"
    }
}

class PetOwner {
    let pet: Pet

    init(pet: Pet) {
        self.pet = pet
    }

    func infoPet() -> String {
        return "Мое животное: \(pet.info())"
    }
}

class Rabbit: Pet {
    let name: String

    init(name: String) {
        self.name = name
    }

    func info() -> String {
        return "Кролик по имени - \(name)"
    }
}
