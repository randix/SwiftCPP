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
        let data = Data([1])
        let sig = Data()
        let p = LensSignParameter()
        p.data = data
        p.sig = sig
        signCallback.sign(p)
        print(p.sig[0] as Any)
    }
}

// Going down to C wants a global function in Swift 😳
func signWithSecureEnclave() { //_ p: LensSignParameter) {
    print(#function, "call SecureEnclave here")
   // p.sig = p.data
}

