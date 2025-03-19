//
//  AuthenticationEnvironmentKey.swift
//  SmartShop
//
//  Created by umtlab03im07 on 18/3/25.
//

import Foundation
import SwiftUI

private struct AuthenticationEnvironmentKey: EnvironmentKey {
    static let defaultValue = AuthenticationController(httpClient: HTTPClient())
}

extension EnvironmentValues {
    
    var authenticationController: AuthenticationController {
        get { self[AuthenticationEnvironmentKey.self] }
        set { self[AuthenticationEnvironmentKey.self] = newValue }
    }
    
}

