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

    @State private var currentIndex: Int = 0

    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 10) {
                if products.indices.contains(currentIndex) {
                    let currentProduct = products[currentIndex]

                    Text("**\(currentProduct.name ?? "Unknown Product")**")
                        .font(.title)

                    Text(currentProduct.productDescription ?? "No description available")

                    Text("Price: $\(currentProduct.price ?? "-")")

                    Text("Provider: \(currentProduct.provider ?? "Unknown")")
                } else {
                    Text("No products found.")
                        .foregroundColor(.gray)
                }

                HStack {
                    Button("Previous") {
                        if currentIndex > 0 {
                            currentIndex -= 1
                        }
                    }
                    .disabled(currentIndex == 0)

                    Spacer()

                    Button("Next") {
                        if currentIndex < products.count - 1 {
                            currentIndex += 1
                        }
                    }
                    .disabled(currentIndex >= products.count - 1)
                }
                .padding(.top, 20)
            }
            .padding()
            .navigationTitle("Product Browser")
        }
    }
}

