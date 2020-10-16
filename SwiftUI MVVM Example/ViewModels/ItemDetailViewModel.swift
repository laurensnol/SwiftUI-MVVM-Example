//
//  ItemDetailViewModel.swift
//  SwiftUI MVVM Example
//
//  Created by Laurens Nolting on 16.10.20.
//

import Foundation
import SwiftUI
import CoreData

class ItemDetailViewModel: ObservableObject {
    private let context = PersistenceController.shared.container.viewContext
    
    @Published var name = ""
    
    @Binding private var itemsToAppend: [Item]
    private var item: Item?
    
    init(appendingTo viewModel: Binding<[Item]>) {
        self._itemsToAppend = viewModel
    }
    
    init(with item: Item) {
        self._itemsToAppend = .constant([])
        self.item = item
        self.name = item.name
    }
    
    func save() {
        if let item = item {
            let request = NSFetchRequest<Item>(entityName: "Item")
            request.predicate = NSPredicate(format: "id = %@", item.id.uuidString)
            
            do {
                let results = try self.context.fetch(request)
                if let itemToUpdate = results.first {
                    itemToUpdate.name = self.name
                }
                
                try self.context.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
            
        } else {
            let item = Item(context: self.context)
            item.id = UUID()
            item.name = self.name
            self.itemsToAppend.append(item)
            
            do {
                try self.context.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}
