//
//  Errors.swift
//  SmartShop
//
//  Created by umtlab03im07 on 21/3/25.
//

import Foundation

enum ProductError: Error {
    case missingUserId
    case invalidPrice
    case operationFailed(String)
    case missingImage
    case uploadFailed(String)
    case productNotFound
}

enum UserError: Error {
    case missingId
    case operationFailed(String)
}

enum CartError: Error {
    case operationFailed(String)
}

