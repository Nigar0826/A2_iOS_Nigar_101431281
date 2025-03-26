//
//  Product+CoreDataProperties.swift
//  A2_iOS_Nigar_101431281
//
//  Created by Nigar Ahmadova on 2025-03-26.
//
//

import Foundation
import CoreData


extension ProductEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ProductEntity> {
        return NSFetchRequest<ProductEntity>(entityName: "Product")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var price: String?
    @NSManaged public var productDescription: String?
    @NSManaged public var provider: String?

}

extension ProductEntity : Identifiable {

}
