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

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
