//
//  main.swift
//  CompositeDesignPattern
//
//  Created by Galushka on 24.01.2020.
//  Copyright © 2020 Galushka. All rights reserved.
//

import Foundation

// MARK: - Interfaces

protocol Encryptor {
    func encrypt(_ string: String) -> String
}

protocol Decrypter {
    func decrypt(_ string: String) -> String
}

// Following ISP
typealias Cryptable = Encryptor & Decrypter

// MARK: - TripleDES Encryption

struct TripleDESCrypter: Cryptable {
    func encrypt(_ string: String) -> String {
        CaesarCipher().caesar(string: string, shift: 2) //string + "<TripleDESCrypter>"
    }
    
    func decrypt(_ string: String) -> String {
        CaesarCipher().caesar(string: string, shift: -2) //string.replacingOccurrences(of: "<TripleDESCrypter>", with: "")
    }
}

// MARK: - RSA Encryption

struct RSACrypter: Cryptable {
    func encrypt(_ string: String) -> String {
        CaesarCipher().caesar(string: string, shift: 9) //string + "<RSA>"
    }
    
    func decrypt(_ string: String) -> String {
        CaesarCipher().caesar(string: string, shift: -9) //string.replacingOccurrences(of: "<RSA>", with: "")
    }
}

// MARK: - BlowFish Encryption

struct BlowFishCrypter: Cryptable {
    func encrypt(_ string: String) -> String {
        CaesarCipher().caesar(string: string, shift: 1) //string + "<BlowFish>"
    }
    
    func decrypt(_ string: String) -> String {
        CaesarCipher().caesar(string: string, shift: -1) //string.replacingOccurrences(of: "<BlowFish>", with: "")
    }
}

// MARK: - AES Encryption

struct AESCrypter: Cryptable {
    func encrypt(_ string: String) -> String {
        CaesarCipher().caesar(string: string, shift: 32) //string + "<AES>"
    }
    
    func decrypt(_ string: String) -> String {
        CaesarCipher().caesar(string: string, shift: -32) //string.replacingOccurrences(of: "<AES>", with: "")
    }
}

// MARK: - CompositeCrypter

class CompositeCrypter: Cryptable {
    private let leafs: [Cryptable]
    
    init(crypters: [Cryptable]) {
        self.leafs = crypters
    }
    
    func encrypt(_ string: String) -> String {
        leafs.reduce(string, { $1.encrypt($0) })
    }
    
    func decrypt(_ string: String) -> String {
        leafs.reduce(string, { $1.decrypt($0) })
    }
}

// MARK: - DEMO

let tripleDESCrypter = TripleDESCrypter()
let rsaCrypter = RSACrypter()
let blowFishCrypter = BlowFishCrypter()
let aesCrypter = AESCrypter()

let multiLevelCrypter = CompositeCrypter(crypters: [tripleDESCrypter, rsaCrypter, blowFishCrypter, aesCrypter])

let encryptedMessage = multiLevelCrypter.encrypt(#"user_name="andew_galushka";password="hyper_secure_password1234"#)
let decryptedMessage = multiLevelCrypter.decrypt(encryptedMessage)

print("encrypted: \(encryptedMessage)")
print("decrypted: \(decryptedMessage)")

