//
//  ViewModel.swift
//  share-image-to-instagram-story
//
//  Created by Robert Brennan on 2/24/24.
//

import Foundation
import Photos
import UIKit
import SwiftUI
import CoreData

//
// PERMISSIONS
//
//
// 1. Permission to check is Instagram is installed on phone
//
// To check if Instagram is installed, and to launch the Instagram app, you need permission.
// In XCode > Click <project name> at the top of the Project Navigator (left panel) >
// Click <project name> under Targets > Click "Info" tab > Under "Custom iOS Target Properties",
// right-click and choose "Raw Keys and Values". Hover mouse on a row item and click the (+) icon >
// In the new row, type: "LSApplicationQueriesSchemes" > Hit Enter. Click the small arrow to
// expand the array. In the Value column for Item 0, enter "instagram" (no quotes). Click the (+)
// icon to add another row (i.e. another element in the array). In the Value column for Item 1,
// enter "instagram-stories" (no quotes).
//
// 2. Permission to save to Photos (optional)
//
// To save the photo to the Photos app on the device, Info.plist must
// include NSPhotoLibraryUsageDescription with some description text.
//
// Follow the instructions above to get to "Custom iOS Target Properties".
// In a new row, type: "NSPhotoLibraryUsageDescription" > Hit tab to focus on the Value column >
// Enter reason for accessing photos (user will see this); e.g. "Need Photos access to save image"
//
// The first time the user saves an image, they will be prompted for permission.
//

class ViewModel: ObservableObject {
    private var managedObjectContext: NSManagedObjectContext
    
    @Published var myImage: UIImage?
    @Published var showImageCover = false
    @Published var photosAccessDenied = false
    
    init(context: NSManagedObjectContext) {
        self.managedObjectContext = context
    }
    
    func makeImage() {
        let imageSize = CGSize(width: 500, height: 500)
        let renderer = UIGraphicsImageRenderer(size: imageSize)
        let image = renderer.image { ctx in
            let numberOfLines = Int.random(in: 5...20) // Randomize the number of lines
                    
            for _ in 0..<numberOfLines {
                let startX = CGFloat.random(in: 0...imageSize.width)
                let startY = CGFloat.random(in: 0...imageSize.height)
                let endX = CGFloat.random(in: 0...imageSize.width)
                let endY = CGFloat.random(in: 0...imageSize.height)
                
                let path = UIBezierPath()
                path.move(to: CGPoint(x: startX, y: startY))
                path.addLine(to: CGPoint(x: endX, y: endY))
                
                ctx.cgContext.addPath(path.cgPath)
                
                // Random color for each line
                let red = CGFloat.random(in: 0...1)
                let green = CGFloat.random(in: 0...1)
                let blue = CGFloat.random(in: 0...1)
                let color = UIColor(red: red, green: green, blue: blue, alpha: 1.0)
                
                ctx.cgContext.setStrokeColor(color.cgColor)
                ctx.cgContext.setLineWidth(CGFloat.random(in: 1...5)) // Random line width
                ctx.cgContext.strokePath()
            }
        }
        
        DispatchQueue.main.async {
            self.myImage = image
            self.showImageCover = true
        }
    }
    
    func saveImageToPhotos(image: UIImage) {
        saveImageToPhotos(image)
    }
    
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            // Handle the saving error
            print("Error saving the image: \(error.localizedDescription)")
        } else {
            // Image was saved successfully
            print("Image saved successfully.")
        }
    }
    
    func saveImageToPhotos(_ image: UIImage) {
        PHPhotoLibrary.requestAuthorization { [weak self] status in
            DispatchQueue.main.async {
                if status == .denied || status == .restricted {
                    self?.photosAccessDenied = true
                } else if status == .authorized {
                    self?.photosAccessDenied = false
                    PHPhotoLibrary.shared().performChanges({
                        PHAssetChangeRequest.creationRequestForAsset(from: image)
                    }) { success, error in
                        DispatchQueue.main.async {
                            if success {
                                print("Image saved successfully")
                            } else {
                                print("Error saving image: \(error?.localizedDescription ?? "")")
                            }
                        }
                    }
                }
            }
        }
    }
}
