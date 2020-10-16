//
//  Item+CoreDataProperties.swift
//  SwiftUI MVVM Example
//
//  Created by Laurens Nolting on 16.10.20.
//
//

import Foundation
import CoreData


extension Item {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        return NSFetchRequest<Item>(entityName: "Item")
    }

    @NSManaged public var id: UUID
    @NSManaged public var name: String
    @NSManaged public var collection: Collection

}

extension Item : Identifiable {

}
