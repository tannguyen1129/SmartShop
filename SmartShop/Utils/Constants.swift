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
        static let createProducts: URL = URL(string: "http://127.0.0.1:8080/api/products")!
    }
}
