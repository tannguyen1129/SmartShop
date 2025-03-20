//
//  ProductStore.swift
//  SmartShop
//
//  Created by umtlab03im07 on 20/3/25.
//

import Foundation
import Observation

@Observable
class ProductStore {
    
    let httpClient: HTTPClient
    private(set) var products: [Product] = []
    
    init(httpClient: HTTPClient = .init()) {
        self.httpClient = httpClient
    }
    
    func loadAllProducts() async throws {
        let resource = Resource(url: Constants.Urls.products, modelType: [Product].self)
        products = try await httpClient.load(resource)
    }
    
}
