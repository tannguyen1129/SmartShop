//
//  Errors.swift
//  SmartShop
//
//  Created by umtlab03im07 on 21/3/25.
//

import Foundation

enum ProductSaveError: Error {
    case missingUserId
    case invvalidPrice
    case operationFailed(String)
    case missingImage
}
