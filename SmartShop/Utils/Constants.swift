//
//  Constants.swift
//  SmartShop
//
//  Created by umtlab03im07 on 19/3/25.
//

import Foundation

struct Constants {
    
    struct Urls {
        static let register: URL = URL(string: "http://127.0.0.1:8080/api/auth/register")!
        static let login: URL = URL(string: "http://127.0.0.1:8080/api/auth/login")!
        static let products: URL = URL(string: "http://127.0.0.1:8080/api/products")!
        static let createProduct: URL = URL(string: "http://127.0.0.1:8080/api/products")!
        static let uploadProductImage = URL(string: "http://127.0.0.1:8080/api/products/upload")!
        static let addCartItem = URL(string: "http://127.0.0.1:8080/api/cart/items")!
        static let loadCart = URL(string: "http://127.0.0.1:8080/api/cart")!
        static let updateUserInfo = URL(string: "http://127.0.0.1:8080/api/user")!
        static let loadUserInfo = URL(string: "http://127.0.0.1:8080/api/user")!
        
        
        static func deleteCartItem(_ cartItemId: Int) -> URL {
            URL(string: "http://127.0.0.1:8080/api/cart/item/\(cartItemId)")!
        }
        
        static func myProducts(_ userId: Int) -> URL {
            URL(string: "http://127.0.0.1:8080/api/products/user/\(userId)")!
        }
        
        static func deleteProduct(_ productId: Int) -> URL {
            URL(string: "http://127.0.0.1:8080/api/products/\(productId)")!
        }
        
        static func updateProduct(_ productId: Int) -> URL {
            URL(string: "http://127.0.0.1:8080/api/products/\(productId)")!
        }
        
    }
    
}

