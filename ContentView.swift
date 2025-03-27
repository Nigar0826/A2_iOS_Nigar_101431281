//
//  ContentView.swift
//  A2_iOS_Nigar_101431281
//
//  Created by Nigar Ahmadova on 2025-03-26.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        entity: ProductEntity.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \ProductEntity.name, ascending: true)],
        animation: .default
    )
    private var products: FetchedResults<ProductEntity>

    @State private var currentIndex = 0
    @State private var searchText = ""

    private var filteredProducts: [ProductEntity] {
        if searchText.isEmpty {
            return Array(products)
        } else {
            return products.filter {
                ($0.name?.localizedCaseInsensitiveContains(searchText) ?? false) ||
                ($0.productDescription?.localizedCaseInsensitiveContains(searchText) ?? false)
            }
        }
    }

    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 10) {
                // Add Product Button
                NavigationLink(destination: AddProductView()) {
                    Text("Add New Product")
                        .font(.headline)
                        .padding(8)
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }

                // View All Products Button
                NavigationLink(destination: ProductListView()) {
                    Text("View All Products")
                        .font(.headline)
                        .padding(8)
                        .frame(maxWidth: .infinity)
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }

                // 🔍 Search
                TextField("Search by name or description", text: $searchText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.vertical, 10)

                // Product Details
                if filteredProducts.indices.contains(currentIndex) {
                    let product = filteredProducts[currentIndex]
                    Text("**\(product.name ?? "Unknown Product")**")
                        .font(.title)
                    Text(product.productDescription ?? "No description available")
                    Text("Price: $\(product.price ?? "-")")
                    Text("Provider: \(product.provider ?? "Unknown")")
                } else {
                    Text("No products found.")
                        .foregroundColor(.gray)
                }

                Spacer()

                // Navigation Buttons
                HStack {
                    Button("Previous") {
                        if currentIndex > 0 {
                            currentIndex -= 1
                        }
                    }
                    .disabled(currentIndex == 0)

                    Spacer()

                    Button("Next") {
                        if currentIndex < filteredProducts.count - 1 {
                            currentIndex += 1
                        }
                    }
                    .disabled(currentIndex >= filteredProducts.count - 1)
                }
                .padding(.top, 20)
            }
            .padding()
            .navigationTitle("Browse Products")
            .onChange(of: searchText) { _ in
                currentIndex = 0 // reset when search changes
            }
        }
    }
}
