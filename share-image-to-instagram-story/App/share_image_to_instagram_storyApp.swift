//
//  share_image_to_instagram_storyApp.swift
//  share-image-to-instagram-story
//
//  Created by Robert Brennan on 2/24/24.
//

import SwiftUI

@main
struct share_image_to_instagram_storyApp: App {
    let persistenceController = PersistenceController.shared
    @StateObject var viewModel: ViewModel

    init() {
        let context = persistenceController.container.viewContext
        _viewModel = StateObject(wrappedValue: ViewModel(context: context))
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
        }
    }
}
