//
//  ProductListView.swift .swift
//  A2_iOS_Nigar_101431281
//
//  Created by Nigar Ahmadova on 2025-03-26.
//

import SwiftUI
import CoreData

// ProductListView - Displays a list of all available products
struct ProductListView: View {
    // Fetch all products from Core Data with sorting by name
    @FetchRequest(
        entity: ProductEntity.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \ProductEntity.name, ascending: true)],
        animation: .default
    )
    private var products: FetchedResults<ProductEntity>

    var body: some View {
        ZStack {
            // Background for consistency
            Color(UIColor.systemGray5)
                .edgesIgnoringSafeArea(.all)

            // Scrollable Product List
            ScrollView {
                VStack(alignment: .leading, spacing: 15) {
                    // Title for Product List
                    Text("Product List")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.top, 20)
                        .padding(.leading, 15)

                    // Display each product in the list
                    ForEach(products) { product in
                        VStack(alignment: .leading, spacing: 10) {
                            // Product Name
                            Text(product.name ?? "Unknown Product")
                                .font(.headline)
                                .foregroundColor(.black)

                            // Product Description
                            Text(product.productDescription ?? "No description available")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        .padding(12)
                        .frame(maxWidth: .infinity, minHeight: 90, alignment: .leading) 
                        .background(Color.white)
                        .cornerRadius(12)
                        .shadow(color: .gray.opacity(0.3), radius: 5, x: 0, y: 2)
                        .padding(.horizontal, 15)
                    }
                }
                .padding(.bottom, 20)
            }
        }
    }
}


