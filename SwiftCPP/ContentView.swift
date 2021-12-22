//
//  ContentView.swift
//  SwiftCPP
//
//  Created by Rand Dow on 12/17/21.
//

import SwiftUI

struct ContentView: View {
    init() {
        let sign = Sign()
        sign.testSign()
    }
    
    var body: some View {
        Text("Hello, world!")
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
