//
//  ImageCoverView.swift
//  share-image-to-instagram-story
//
//  Created by Robert Brennan on 2/24/24.
//

import SwiftUI

struct ImageCoverView: View {
    @EnvironmentObject var viewModel: ViewModel
    
    var body: some View {
        VStack {
            if let image = viewModel.myImage {
                Spacer()
                
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(17)
                    .overlay(
                        RoundedRectangle(cornerRadius: 17)
                            .stroke(Color.black, lineWidth: 2)
                    )
                    .padding()
                
                Spacer()
                
                VStack {
                    if InstagramSharingUtils.canOpenInstagramStories {
                        Button {
                            InstagramSharingUtils.shareToInstagramStories(viewModel.myImage!)
                        } label: {
                            Text("Share to Instagram Story")
                        }
                        .padding()
                    }
                    
                    Button {
                        if let imageToSave = viewModel.myImage {
                            viewModel.saveImageToPhotos(image: imageToSave)
                        }
                    } label: {
                        Text("Save to Photos")
                    }
                    .padding()
                    
                    Button {
                        viewModel.showImageCover = false
                    } label: {
                        Text("Close")
                    }
                    .padding()
                }
                
                Spacer()
            }
        }
    }
}

//#Preview {
//    ImageCoverView()
//}
