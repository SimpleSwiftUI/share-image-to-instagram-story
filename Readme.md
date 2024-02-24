# Share Image to Instagram Story

## Overview
Share Image to Instagram Story is an advanced SwiftUI iOS project demonstrating not only basic image generation but also sharing these images directly to Instagram Stories, provided the Instagram app is installed on the device. This project builds upon the simple image generation by integrating social sharing capabilities, specifically targeting Instagram Stories.

![share-image-to-instagram-story screen capture](screen-capture/share-image-to-instagram-story.gif)

## Features
- **Image Generation**: Generate random images with customizable properties.
- **Save to Photos**: Option to save the generated images to the device's Photos app.
- **Share to Instagram Stories**: Seamlessly share generated images to Instagram Stories, enhancing the app's social sharing capabilities.

## Requirements
- iOS 16.4+
- Xcode 13.0+
- Swift 5

## Installation
To get started, clone the repository or download the project. Open `share-image-to-instagram-story.xcodeproj` in Xcode. Ensure your development environment meets the project's requirements.

## Usage
The main interface offers a "Make Image" button that, upon tapping, generates a random image displayed in a modal view. Users have the option to save the image to Photos or share it directly to Instagram Stories if the Instagram app is installed on their device.

### Generating and Sharing an Image
- **Generating an Image**: Utilize the `ViewModel` class, which handles image generation using `UIGraphicsImageRenderer`.
- **Sharing to Instagram Stories**: The `InstagramSharingUtils` struct provides functionality to share the generated image to Instagram Stories by writing the image to the pasteboard and then opening Instagram.

## Permissions Overview
The app requires specific permissions to function correctly:
1. **Instagram App Check**: To verify Instagram installation and enable sharing to Instagram Stories.
2. **Photos Access**: Optional, for saving images to the Photos app.

Detailed instructions on configuring these permissions are available in the `ViewModel.swift` file.

## Configuring Permissions
Ensure your `Info.plist` is configured with:
- `LSApplicationQueriesSchemes` to include "instagram" and "instagram-stories" for app checks.
- `NSPhotoLibraryUsageDescription` for Photos access, with a user-facing reason for the permission request.

## License
This project is released under the MIT license.

