//
//  DTOs.swift
//  SmartShop
//
//  Created by umtlab03im07 on 19/3/25.
//

import Foundation

struct RegisterResponse: Codable {
    let message: String?
    let success: Bool
}


struct LoginResponse: Codable {
    
    let message: String?
    let token: String?
    let success: Bool
    let userId: Int?
    let username: String?
}

struct ErrorResponse: Codable {
    let message: String?
}


