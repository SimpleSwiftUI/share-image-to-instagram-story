//
//  ContentView.swift
//  share-image-to-instagram-story
//
//  Created by Robert Brennan on 2/24/24.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @EnvironmentObject var viewModel: ViewModel

    var body: some View {
        VStack {
            Button {
                viewModel.makeImage()
                viewModel.showImageCover = true
            } label: {
                Text("Make Image")
            }
            .padding()
        }
        .fullScreenCover(isPresented: $viewModel.showImageCover) {
            ImageCoverView()
        }
    }
}



//#Preview {
//    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
//}
