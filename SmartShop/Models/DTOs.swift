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

struct ErrorResponse: Codable {
    let message: String?
}
