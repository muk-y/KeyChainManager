//
//  File.swift
//  
//
//  Created by ekmacmini43 on 11/01/2022.
//

import Foundation
import SwiftKeychainWrapper

class Person: Codable {
    
    var name: String
    
    init(name: String) {
        self.name = name
    }
}

class JSONUtilities {
    static let shared = JSONUtilities()

    func encode<T: Codable>(object: T) -> Data? {
        do {
            let encoder = JSONEncoder()
            return try encoder.encode(object)
        } catch let error {
            print(error.localizedDescription)
        }
        return nil
    }

    func decode<T: Decodable>(json: Data, as clazz: T.Type) -> T? {
        do {
            let decoder = JSONDecoder()
            let data = try decoder.decode(T.self, from: json)
            
            return data
        } catch {
            print("An error occurred while parsing JSON during decode")
        }
        return nil
    }
}


class Keychain {
    
//    MARK: SET ANY TYPE OF CODABLE OBJECT IN KEYCHAIN
    class func set <T: Codable>(object: T, forKey :String){
        let encoded = JSONUtilities.shared.encode(object: object)
        let key = forKey
        KeychainWrapper.standard[KeychainWrapper.Key(rawValue: key)] = encoded
    }
    
    //    MARK: GET ANY TYPE OF CODABLE OBJECT IN KEYCHAIN
    class func get <T: Codable> (type: T.Type, forKey key:String) -> T? {
        let dataObject = KeychainWrapper.standard.data(forKey: key) ?? Data()
        let decode = JSONUtilities.shared.decode(json: dataObject, as: type)
        return decode
    }
    
    //    MARK: CHCEK IF ANY TYPE OF CODABLE OBJECT IN KEYCHAIN IS AVAILABLE
    class func isAvailable <T: Codable> (type: T.Type, forKey key:String) -> Bool {
        let dataObject = KeychainWrapper.standard.data(forKey: key) ?? Data()
        let decode = JSONUtilities.shared.decode(json: dataObject, as: type)
        guard let _ = decode else { return false }
        return true
    }
    
    //    MARK: CLEAR ANY TYPE OF CODABLE OBJECT IN KEYCHAIN IS AVAILABLE
    class func clear(_ type:String? = nil) {
        if let _type = type {
            KeychainWrapper.standard.removeObject(forKey: _type)
        }else{
            KeychainWrapper.standard.removeAllKeys()
        }
        
    }
}

struct GlobalConstants {
    
    struct KeyChainValues {
        
//        MARK: PERSON OBJECT IN A GLOBAL VARIABLE
        static var person: Person? {
            get {
                return Keychain.get(type: Person.self, forKey: GlobalConstants.KeyChainKey.person)
            }
            set {
                Keychain.set(object: newValue, forKey: GlobalConstants.KeyChainKey.person)
            }
        }
        
        static var basicBoolValue: Bool! {
            get {
                return KeychainWrapper.standard.bool(forKey: GlobalConstants.KeyChainKey.basicBoolType) ?? false
            }
            set {
                KeychainWrapper.standard.set(newValue, forKey: GlobalConstants.KeyChainKey.basicBoolType)
            }
        }
        
    }
    
    // key chain keys for the object
    struct KeyChainKey {
        static let person = "person"
        static let basicBoolType = "basic"
    }
}
