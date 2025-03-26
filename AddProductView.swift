//
//  AddProductView.swift
//  A2_iOS_Nigar_101431281
//
//  Created by Nigar Ahmadova on 2025-03-26.
//

import SwiftUI

struct AddProductView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss

    @State private var name: String = ""
    @State private var description: String = ""
    @State private var price: String = ""
    @State private var provider: String = ""

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Product Details")) {
                    TextField("Name", text: $name)
                    TextField("Description", text: $description)
                    TextField("Price", text: $price)
                        .keyboardType(.decimalPad)
                    TextField("Provider", text: $provider)
                }

                Button("Save Product") {
                    let newProduct = ProductEntity(context: viewContext)
                    newProduct.id = UUID()
                    newProduct.name = name
                    newProduct.productDescription = description
                    newProduct.price = price
                    newProduct.provider = provider

                    do {
                        try viewContext.save()
                        dismiss()
                    } catch {
                        print("Failed to save product: \(error)")
                    }
                }
            }
            .navigationTitle("Add Product")
        }
    }
}

