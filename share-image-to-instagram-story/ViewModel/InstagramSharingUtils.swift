//
//  InstagramStories.swift
//  share-image-to-instagram-story
//
//  Created by Robert Brennan on 2/24/24.
//

import Foundation
import SwiftUI

// Credit: https://codakuma.com/instagram-stories-sharing-swiftui/

// Important: see notes on Permissions in ViewModel.swift.

struct InstagramSharingUtils {
    // Returns a URL if Instagram Stories can be opened, otherwise returns nil.
    private static var instagramStoriesUrl: URL? {
        let myBundleName = Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as? String ?? "Unknown"        
        if let url = URL(string: "instagram-stories://share?source_application=\(myBundleName)") {
            if UIApplication.shared.canOpenURL(url) {
                return url
            }
        }
        return nil
    }
        
    // Convenience wrapper to return a boolean for `instagramStoriesUrl`
    static var canOpenInstagramStories: Bool {
        return instagramStoriesUrl != nil
    }
        
    // If Instagram Stories is available, writes the image to the pasteboard and
    // then opens Instagram.
    static func shareToInstagramStories(_ image: UIImage) {
        
        // Check that Instagram Stories is available.
        guard let instagramStoriesUrl = instagramStoriesUrl else {
            return
        }
        
        // Convert the image to data that can be written to the pasteboard.
        let imageDataOrNil = UIImage.pngData(image)
        guard let imageData = imageDataOrNil() else {
            print("Image data not available.")
            return
        }
        
        let backgroundTopColorHexCode = "#FF0000"   // color above image
        let backgroundBottomColorHexCode = "#0000FF"    // color below image

        let pasteboardItem = [
            "com.instagram.sharedSticker.stickerImage": imageData,
            "com.instagram.sharedSticker.backgroundTopColor": backgroundTopColorHexCode,
            "com.instagram.sharedSticker.backgroundBottomColor": backgroundBottomColorHexCode
        ] as [String : Any]
        // let pasteboardItem = ["com.instagram.sharedSticker.backgroundImage": imageData]  // Alternatively, set as background image
        
        let pasteboardOptions = [UIPasteboard.OptionsKey.expirationDate: Date().addingTimeInterval(60 * 5)]
        
        // Add the image to the pasteboard. Instagram will read the image from the pasteboard when it's opened.
        UIPasteboard.general.setItems([pasteboardItem], options: pasteboardOptions)
        
        // Open Instagram.
        UIApplication.shared.open(instagramStoriesUrl, options: [:], completionHandler: nil)
    }
}
