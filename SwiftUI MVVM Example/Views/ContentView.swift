//
//  ContentView.swift
//  SwiftUI MVVM Example
//
//  Created by Laurens Nolting on 16.10.20.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        entity: Collection.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Collection.name, ascending: true)]
    ) private var collections: FetchedResults<Collection>
    
    var body: some View {
        NavigationView {
            Form {
                ForEach(collections) { collection in
                    NavigationLink(destination: CollectionDetailView(with: collection)) {
                        HStack {
                            Text(collection.name)
                            Spacer()
                            Text("\(collection.items.count) Items")
                                .foregroundColor(.secondary)
                        }
                    }
                }
                .onDelete { indexSet in
                    for index in indexSet {
                        self.viewContext.delete(self.collections[index])
                    }
                    
                    do {
                        try viewContext.save()
                    } catch {
                        let nsError = error as NSError
                        fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                    }
                }
            }
            .navigationTitle("Collections")
            .navigationBarItems(trailing: NavigationLink(destination: CollectionDetailView()) {
                Image(systemName: "plus.circle")
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
