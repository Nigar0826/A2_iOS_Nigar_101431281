//
//  Persistence.swift
//  A2_iOS_Nigar_101431281
//
//  Created by Nigar Ahmadova on 2025-03-26.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()
    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "A2_iOS_Nigar_101431281")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
        let viewContext = container.viewContext

        let fetchRequest: NSFetchRequest<ProductEntity> = ProductEntity.fetchRequest()

        do {
            let count = try viewContext.count(for: fetchRequest)
            if count == 0 {
                let sampleProducts = [
                    ("MacBook Air M2", "Lightweight Apple laptop with M2 chip", 1299.99, "Apple"),
                    ("MacBook Pro 16", "High-performance laptop with M3 Pro chip", 2499.99, "Apple"),
                    ("iPhone 15 Pro Max", "Flagship iPhone with triple camera system", 1599.99, "Apple"),
                    ("iPad Air", "Ultra-light tablet with M1 chip", 899.99, "Apple"),
                    ("Apple Watch Ultra", "Rugged smartwatch with advanced sensors", 1099.99, "Apple"),
                    ("AirPods Max", "Premium over-ear noise-cancelling headphones", 779.99, "Apple"),
                    ("HomePod Mini", "Smart speaker with Siri integration", 129.99, "Apple"),
                    ("Magic Keyboard", "Wireless keyboard with Touch ID", 199.99, "Apple"),
                    ("Apple Pencil (2nd Gen)", "Precision stylus for iPad Pro and Air", 169.99, "Apple"),
                    ("Studio Display", "5K Retina monitor with aluminum enclosure", 1999.99, "Apple")
                ]

                for (name, description, price, provider) in sampleProducts {
                    let product = ProductEntity(context: viewContext)
                    product.id = UUID()
                    product.name = name
                    product.productDescription = description
                    product.price = String(format: "%.2f", price)
                    product.provider = provider
                }

                try viewContext.save()
            }
        } catch {
            print("Error inserting sample products: \(error.localizedDescription)")
        }

    }
        
}
