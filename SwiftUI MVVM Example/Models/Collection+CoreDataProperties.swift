//
//  Collection+CoreDataProperties.swift
//  SwiftUI MVVM Example
//
//  Created by Laurens Nolting on 16.10.20.
//
//

import Foundation
import CoreData


extension Collection {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Collection> {
        return NSFetchRequest<Collection>(entityName: "Collection")
    }

    @NSManaged public var id: UUID
    @NSManaged public var name: String
    @NSManaged public var items: NSSet

}

// MARK: Generated accessors for items
extension Collection {

    @objc(addItemsObject:)
    @NSManaged public func addToItems(_ value: Item)

    @objc(removeItemsObject:)
    @NSManaged public func removeFromItems(_ value: Item)

    @objc(addItems:)
    @NSManaged public func addToItems(_ values: NSSet)

    @objc(removeItems:)
    @NSManaged public func removeFromItems(_ values: NSSet)

}

extension Collection : Identifiable {

}
