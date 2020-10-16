//
//  ItemDetailView.swift
//  SwiftUI MVVM Example
//
//  Created by Laurens Nolting on 16.10.20.
//

import SwiftUI

struct ItemDetailView: View {
    @Environment(\.presentationMode) private var presentationMode
    @ObservedObject private var viewModel: ItemDetailViewModel
    
    init(appendingTo viewModel: Binding<[Item]>) {
        self.viewModel = ItemDetailViewModel(appendingTo: viewModel)
    }
    
    init(with item: Item) {
        self.viewModel = ItemDetailViewModel(with: item)
    }
    
    var body: some View {
        Form {
            TextField("Name", text: self.$viewModel.name)
        }
        .navigationTitle("Item")
        .navigationBarItems(trailing: Button(action: {
            viewModel.save()
            self.presentationMode.wrappedValue.dismiss()
        }, label: {
            Text("Done")
        }))
    }
}

struct ItemDetailView_Preview: PreviewProvider {
    static var previews: some View {
        ItemDetailView(appendingTo: .constant([]))
    }
}
