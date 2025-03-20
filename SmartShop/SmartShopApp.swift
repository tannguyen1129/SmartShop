//
//  SmartShopApp.swift
//  SmartShop
//
//  Created by umtlab03im07 on 18/3/25.
//

import SwiftUI

@main
struct SmartShopApp: App {
    
    @State private var productStore = ProductStore(httpClient: HTTPClient())
    
    var body: some Scene {
        WindowGroup {
            HomeScreen()
                .environment(\.authenticationController, .development)
                .environment(productStore)
        }
    }
}

