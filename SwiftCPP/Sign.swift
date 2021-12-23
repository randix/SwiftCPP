//
//  Sign.swift
//  SwiftCPP
//
//  Created by Rand Dow on 12/17/21.
//

import Foundation

class Sign {
    
    func testSign() {
        print(#function)
        
        // set up the callbacks
        let signCallback = SignCallback()
        signCallback.setCallback(signWithSecureEnclave)
        
        // test by calling the "claims generator"
        signCallback.sign()
    }
}

// Going down to C wants a global function in Swift 😳
func signWithSecureEnclave(_ data: Data) -> Data {
    print(#function, "call SecureEnclave here")
    print("data.count \(data.count)")
    for i in 0..<data.count {
        print(data[i])
    }
    return data
}

