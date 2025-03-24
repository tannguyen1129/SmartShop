//
//  CartScreen.swift
//  SmartShop
//
//  Created by umtlab03im07 on 24/3/25.
//

import SwiftUI

struct CartScreen: View {
    
    @Environment(CartStore.self) private var cartStore
    @AppStorage("userId") private var userId: Int?
    
    @State private var proceedToCheckout = false
    
    var body: some View {
        List {
            if let cart = cartStore.cart {
                
                HStack {
                    Spacer()
                    Text("Total: ")
                        .font(.title)
                    Text(cart.total, format: .currency(code: "USD"))
                        .font(.title)
                        .bold()
                    Spacer()
                }
                
                Button(action: {
                    proceedToCheckout = true
                }) {
                    
                    Text("Proceed to checkout ^[(\(cart.itemsCount) Item](inflect: true))")
                        .bold()
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green)
                        .foregroundStyle(.white)
                        .cornerRadius(8)
                }.buttonStyle(.borderless)
                
                CartItemListView(cartItems: cart.cartItems)
                
            } else {
                ContentUnavailableView("No items in the cart.", systemImage: "cart")
            }
        }.navigationDestination(isPresented: $proceedToCheckout) {
            if let cart = cartStore.cart {
                CheckoutScreen(cart: cart)
            }
        }
       
    }
}

#Preview {
    NavigationStack {
        CartScreen()
            .environment(CartStore(httpClient: .development))
    }
}
