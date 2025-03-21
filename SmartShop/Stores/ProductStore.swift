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
    private(set) var myProducts: [Product] = []
    
    init(httpClient: HTTPClient = .init()) {
        self.httpClient = httpClient
    }
    
    func loadAllProducts() async throws {
        let resource = Resource(url: Constants.Urls.products, modelType: [Product].self)
        products = try await httpClient.load(resource)
    }
    
    func saveProduct(_ product: Product) async throws {
        let resource = Resource(url: Constants.Urls.createProducts, method: .post(product.encode()), modelType: CreateProductResponse.self)
        let resoure = try await httpClient.load(resource)
        if let product = response.product, response.success {
            myProducts.append(product)
        } else {
            throw ProductSaveError.operationFailed(response.message ?? )
        }
    }
    
}
