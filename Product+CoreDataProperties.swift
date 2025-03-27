//
//  Product+CoreDataProperties.swift
//  A2_iOS_Nigar_101431281
//
//  Created by Nigar Ahmadova on 2025-03-26.
//
//

import Foundation
import CoreData

// ProductEntity Core Data Properties
// Extension to define properties and fetch request for ProductEntity.
extension ProductEntity {

    // Fetch request to retrieve ProductEntity objects from Core Data.
    // A fetch request for ProductEntity.
    @nonobjc public class func fetchRequest() -> NSFetchRequest<ProductEntity> {
        return NSFetchRequest<ProductEntity>(entityName: "Product")
    }

    // Core Data Managed Properties
    @NSManaged public var id: UUID?                       // Unique identifier for the product
    @NSManaged public var name: String?                  // Name of the product
    @NSManaged public var price: String?                // Price of the product
    @NSManaged public var productDescription: String?  // Description of the product
    @NSManaged public var provider: String?           // Provider or manufacturer of the product

}

// Conforming to Identifiable
// Makes ProductEntity identifiable for use in SwiftUI lists.
extension ProductEntity : Identifiable {

}
