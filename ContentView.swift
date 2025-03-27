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
            VStack(alignment: .leading, spacing: 15) {
                // Navigation to Add Product View
                NavigationLink(destination: AddProductView()) {
                    Text("Add New Product")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(12)
                        .shadow(radius: 4)
                }
                .padding(.horizontal)

                // Navigation to Product List View
                NavigationLink(destination: ProductListView()) {
                    Text("View All Products")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue.opacity(0.9))
                        .cornerRadius(12)
                        .shadow(radius: 4)
                }
                .padding(.horizontal)

                // 🔍 Search Bar
                TextField("🔍 Search by name or description", text: $searchText)
                    .padding(12)
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding(.horizontal)

                // Product Details Card
                if filteredProducts.indices.contains(currentIndex) {
                    let product = filteredProducts[currentIndex]
                    VStack(alignment: .leading, spacing: 8) {
                        Text(product.name ?? "Unknown Product")
                            .font(.title2)
                            .fontWeight(.bold)

                        Text(product.productDescription ?? "No description available")
                            .foregroundColor(.gray)
                            .padding(.bottom, 5)

                        Text("Price: $\(product.price ?? "-")")
                        Text("Provider: \(product.provider ?? "Unknown")")
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.white)
                    .cornerRadius(12)
                    .shadow(color: .gray.opacity(0.3), radius: 5, x: 0, y: 2)
                    .padding(.horizontal)
                } else {
                    Text("No products found.")
                        .foregroundColor(.red)
                        .padding(.top, 20)
                        .frame(maxWidth: .infinity, alignment: .center)
                }

                Spacer()

                // Navigation Buttons
                HStack {
                    Button(action: {
                        if currentIndex > 0 {
                            currentIndex -= 1
                        }
                    }) {
                        Text("⬅️ Previous")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(currentIndex == 0 ? Color.gray : Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                    }
                    .disabled(currentIndex == 0)

                    Button(action: {
                        if currentIndex < filteredProducts.count - 1 {
                            currentIndex += 1
                        }
                    }) {
                        Text("Next ➡️")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(currentIndex >= filteredProducts.count - 1 ? Color.gray : Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                    }
                    .disabled(currentIndex >= filteredProducts.count - 1)
                }
                .padding(.horizontal)
            }
            .padding(.top)
            .navigationTitle("Browse Products")
            .onChange(of: searchText) { _ in
                currentIndex = 0 // reset index on search
            }
        }
    }
}
