//
//  CollectionDetailViewModel.swift
//  SwiftUI MVVM Example
//
//  Created by Laurens Nolting on 16.10.20.
//

import Foundation
import SwiftUI

class CollectionDetailViewModel: ObservableObject {
    private let context = PersistenceController.shared.container.viewContext
    
    @Published var name = ""
    @Published var items: [Item] = []
    
    private var collection: Collection?
    
    init(with collection: Collection? = nil) {
        self.collection = collection
        
        if let collection = collection {
            self.name = collection.name
            self.items = collection.items.allObjects as? [Item] ?? []
        }
    }
    
    func save() {
        if let collection = self.collection {
            collection.name = self.name
            
            // Remove all current items...
            collection.removeFromItems(collection.items)
            // And replace them with those of the ViewModel
            for item in self.items {
                collection.addToItems(item)
            }
        } else {
            let collection = Collection(context: self.context)
            collection.id = UUID()
            collection.name = self.name
            
            for item in self.items {
                collection.addToItems(item)
            }
        }
        
        do {
            try context.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}
