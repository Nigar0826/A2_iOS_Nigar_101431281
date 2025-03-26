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

    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 10) {
                if let firstProduct = products.first {
                    Text("**\(firstProduct.name ?? "Unknown Product")**")
                        .font(.title)
                    Text(firstProduct.productDescription ?? "No description available")
                    Text("Price: $\(firstProduct.price ?? "-")")
                    Text("Provider: \(firstProduct.provider ?? "Unknown")")
                } else {
                    Text("No products found.")
                        .foregroundColor(.gray)
                }
            }
            .padding()
            .navigationTitle("First Product")
        }
    }
}
