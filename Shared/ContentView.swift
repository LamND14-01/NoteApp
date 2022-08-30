//
//  ContentView.swift
//  Shared
//
//  Created by Eloo on 8/30/22.
//

import SwiftUI

struct ContentView: View {
    @State var count = 0
    var body: some View {
        Text("\(count)")
        Button("Test button") {
            count += 1
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
