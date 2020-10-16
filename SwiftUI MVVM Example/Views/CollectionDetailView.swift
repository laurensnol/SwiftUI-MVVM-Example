//
//  CollectionDetailView.swift
//  SwiftUI MVVM Example
//
//  Created by Laurens Nolting on 16.10.20.
//

import SwiftUI

struct CollectionDetailView: View {
    @Environment(\.presentationMode) private var presentationMode
    @ObservedObject private var viewModel: CollectionDetailViewModel
    
    init(with collection: Collection? = nil) {
        self.viewModel = CollectionDetailViewModel(with: collection)
    }
    
    var body: some View {
        Form {
            Section {
                TextField("Name", text: self.$viewModel.name)
            }
            
            Section(header: HStack {
                Text("\(self.viewModel.items.count) Items")
                Spacer()
                NavigationLink(destination: ItemDetailView(appendingTo: self.$viewModel.items)) {
                    Text("Add")
                        .foregroundColor(.accentColor)
                }
            }) {
                ForEach(self.viewModel.items) { item in
                    NavigationLink(destination: ItemDetailView(with: item)) {
                        Text(item.name)
                    }
                }
                .onDelete { indexSet in
                    for index in indexSet {
                        self.viewModel.items.remove(at: index)
                    }
                }
            }
        }
        .navigationTitle("Collection")
        .navigationBarItems(trailing: Button(action: {
            viewModel.save()
            self.presentationMode.wrappedValue.dismiss()
        }, label: {
            Text("Done")
        }))
    }
}

struct CollectionDetailView_Preview: PreviewProvider {
    static var previews: some View {
        CollectionDetailView()
    }
}

