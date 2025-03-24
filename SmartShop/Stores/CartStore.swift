//
//  CartStore.swift
//  SmartShop
//
//  Created by umtlab03im07 on 24/3/25.
//

import Foundation
import Observation

@MainActor
@Observable
class CartStore {
    
    let httpClient: HTTPClient
    var cart: Cart?
    
    var lastError: Error?
    
    init(httpClient: HTTPClient) {
        self.httpClient = httpClient
    }
    
    func emptyCart() {
        cart?.cartItems = []
    }
    
    func deleteCartItem(cartItemId: Int) async throws {
        
        let resource = Resource(url: Constants.Urls.deleteCartItem(cartItemId), method: .delete, modelType: DeleteCartItemResponse.self)
        
        let response = try await httpClient.load(resource)
        
        if response.success {
            if let cart = cart {
                self.cart?.cartItems = cart.cartItems.filter { $0.id != cartItemId }
            }
        } else {
            throw CartError.operationFailed(response.message ?? "")
        }
    }
    
    func loadCart() async {
        
        do {
            let resource = Resource(url: Constants.Urls.loadCart, modelType: CartResponse.self)
            let response = try await httpClient.load(resource)
            
            if let cart = response.cart, response.success {
                self.cart = cart
            }
        } catch {
            lastError = error
        }
    }
    
    func updateItemQuantity(productId: Int, quantity: Int) async throws {
        try await addItemToCart(productId: productId, quantity: quantity)
    }
    
    func addItemToCart(productId: Int, quantity: Int) async throws {
        
        let body = ["productId": productId, "quantity": quantity]
        let bodyData = try JSONEncoder().encode(body)
        
        let resource = Resource(url: Constants.Urls.addCartItem, method: .post(bodyData), modelType: CartItemResponse.self)
        let response = try await httpClient.load(resource)
        
        if let cartItem = response.cartItem, response.success {
            // initialize the cart if it is nil
            if cart == nil {
                guard let userId = UserDefaults.standard.userId else { throw UserError.missingId }
                cart = Cart(userId: userId)
            }
            
            // if item already in cart then update it
            if let index = cart?.cartItems.firstIndex(where: { $0.id == cartItem.id }) {
                cart?.cartItems[index] = cartItem
            } else {
                // add as new cart item
                cart?.cartItems.append(cartItem)
            }
        } else {
            throw CartError.operationFailed(response.message ?? "")
        }
        
    }
    
}
