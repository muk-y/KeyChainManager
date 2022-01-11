import XCTest
@testable import KeyChainManager

final class KeyChainManagerTests: XCTestCase {
    
    let key = "person"
    
    func test_key_chain_retrieve_returns_nil() {
        let person = KeyChainManager.standard.retrieve(type: Person.self, forKey: key)
        XCTAssertNil(person)
    }
    
    func test_key_chain_save_returns_not_nil() {
        let person = Person(name: "Mukesh Shakya")
        //        KeyChainManager.standard.set(object: person, forKey: key)
        GlobalConstants.KeyChainValues.person = person
        //        let savedPerson = KeyChainManager.standard.retrieve(type: Person.self, forKey: key)
        
        let savedPerson = GlobalConstants.KeyChainValues.person
        XCTAssertNotNil(savedPerson)
        XCTAssertEqual(person.name, savedPerson?.name)
    }
    
    
}
