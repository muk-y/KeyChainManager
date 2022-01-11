//
//  ViewController.swift
//  Example
//
//  Created by ekmacmini43 on 11/01/2022.
//

import UIKit
import KeyChainManager

class ViewController: UIViewController {
    
    class Person: Codable {
        
        let name: String
        
        init(name: String) {
            self.name = name
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let person = Person(name: "Mukesh Shakya")
        KeyChainManager.standard.set(object: person, forKey: "person")
        let savedPerson = KeyChainManager.standard.retrieve(type: Person.self, forKey: "person")
        print(savedPerson?.name ?? "")
    }


}

