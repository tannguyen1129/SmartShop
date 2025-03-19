//
//  ContentView.swift
//  SmartShop
//
//  Created by umtlab03im07 on 18/3/25.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.authenticationController) private var authenticationController
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
