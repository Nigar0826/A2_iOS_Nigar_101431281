//
//  AddProductView.swift
//  A2_iOS_Nigar_101431281
//
//  Created by Nigar Ahmadova on 2025-03-26.
//

import SwiftUI

// AddProductView - View for adding a new product
struct AddProductView: View {
    // Access the managed object context for Core Data
    @Environment(\.managedObjectContext) private var viewContext
    // Dismiss the view after saving the product
    @Environment(\.dismiss) private var dismiss

    // State variables to hold user input for product fields
    @State private var name: String = ""
    @State private var description: String = ""
    @State private var price: String = ""
    @State private var provider: String = ""

    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 20) {
                // Input Fields with Correct Styling
                VStack(spacing: 15) {
                    // Name Field
                    TextField("Name", text: $name)
                        .padding()
                        .background(Color(UIColor.systemGray6))
                        .cornerRadius(10)

                    // Description Field
                    TextField("Description", text: $description)
                        .padding()
                        .background(Color(UIColor.systemGray6))
                        .cornerRadius(10)

                    // Price Field
                    TextField("Price", text: $price)
                        .keyboardType(.decimalPad)
                        .padding()
                        .background(Color(UIColor.systemGray6))
                        .cornerRadius(10)

                    // Provider Field
                    TextField("Provider", text: $provider)
                        .padding()
                        .background(Color(UIColor.systemGray6))
                        .cornerRadius(10)
                }
                .padding()
                .background(Color.white)
                .cornerRadius(12)
                .shadow(radius: 5)
                .padding(.horizontal, 20)

                Spacer()

                // Save Product Button
                Button(action: {
                    saveProduct()
                }) {
                    Text("Save Product")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(12)
                        .shadow(radius: 3)
                }
                .padding(.horizontal, 20)
            }
            .padding(.bottom, 20)
            .navigationTitle("Add Product")
            .padding(.top, 30)
            .background(Color(UIColor.systemGray5).edgesIgnoringSafeArea(.all))
        }
    }

    // Save Product Logic
    private func saveProduct() {
        let newProduct = ProductEntity(context: viewContext)
        newProduct.id = UUID()
        newProduct.name = name
        newProduct.productDescription = description
        newProduct.price = price
        newProduct.provider = provider

        // Save the product to Core Data
        do {
            try viewContext.save()
            dismiss() // Dismiss the view after saving
        } catch {
            print("Failed to save product: \(error)")
        }
    }
}
