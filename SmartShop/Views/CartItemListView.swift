//
//  CartItemListView.swift
//  SmartShop
//
//  Created by umtlab03im07 on 24/3/25.
//

import SwiftUI

struct CartItemListView: View {
    
    let cartItems: [CartItem]
    
    var body: some View {
        ForEach(cartItems) { cartItem in
            CartItemView(cartItem: cartItem)
        }.listStyle(.plain)
    }
}

#Preview {
    CartItemListView(cartItems: Cart.preview.cartItems)
}
