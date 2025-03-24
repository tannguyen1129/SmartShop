//
//  ProductListScreen.swift
//  SmartShop
//
//  Created by umtlab03im07 on 20/3/25.
//

import SwiftUI

struct ProductListScreen: View {
    
    @Environment(ProductStore.self) private var productStore
    
    var body: some View {
        List(productStore.products) { product in
            
            NavigationLink {
                ProductDetailScreen(product: product)
            } label: {
                ProductCellView(product: product)
                    //.listRowSeparator(.hidden)
            }
           
        }
        .listStyle(.plain)
        .navigationTitle("New Arrivals")
        .task {
            do {
                try await productStore.loadAllProducts()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

#Preview {
    NavigationStack {
        ProductListScreen()
    }
    .environment(ProductStore(httpClient: .development))
    .environment(CartStore(httpClient: .development))
    
}
