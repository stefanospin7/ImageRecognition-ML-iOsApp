//
//  ContentView.swift
//  objectRecognitionApp(ML)
//
//  Created by Stefano  on 23/06/22.
//


//This iOs app uses SwiftUI, machine learning (MobileNetV2) which let the user use camera and access library to get as result the subject of the image.
//
//Useful links:
//
//Apple developer machine learning models:
//
//https://developer.apple.com/machine-learning/models/
//
//Cornell University project:
//
//https://arxiv.org/abs/1801.04381




import SwiftUI

struct ContentView: View {
    @State var isPresenting: Bool = false
    @State var uiImage: UIImage?
    @State var sourceType: UIImagePickerController.SourceType = .photoLibrary
    
    @ObservedObject var imageClassifierObject: ImageRecognizer
    
    var body: some View {
        VStack{
            HStack{
            Text("GUESS WHAT")
                .font(.title)
                .foregroundColor(.cyan)
          
                Image(systemName: "questionmark.square.dashed")
                    .font(.title)
                    .foregroundColor(.cyan)
                
            }
            HStack{
                Image(systemName: "photo.fill")
                    .onTapGesture {
                        isPresenting = true
                        sourceType = .photoLibrary
                    }
                
                Image(systemName: "camera.aperture")
                    .onTapGesture {
                        isPresenting = true
                        sourceType = .camera
                    }
            }
            .font(.title)
            .foregroundColor(.blue)
            
            
            Rectangle()
                .strokeBorder()
                .foregroundColor(.cyan)
                .overlay(
                    Group {
                        if uiImage != nil {
                            Image(uiImage: uiImage!)
                                .resizable()
                                .scaledToFit()
                        }
                    }
                )
            
            
            VStack{
                Button(action: {
                    if uiImage != nil {
                        imageClassifierObject.detect(uiImage: uiImage!)
                    }
                }) {
                    HStack{
                        Spacer()
                    Image(systemName: "circle.grid.cross")
                        .foregroundColor(.cyan)
                        .font(.title)
                        
                        
                    }
                }
                
                
                Group {
                    if let imageClass = imageClassifierObject.imageClass {
                        HStack{
                            Text("Image categories:")
                                .font(.caption)
                            Text(imageClass)
                                .bold()
                        }
                    } else {
                        HStack{
                            Text("Image categories: NA")
                                .font(.caption)
                        }
                    }
                }
                .font(.subheadline)
                .padding()
                
            }
        }
        
        .sheet(isPresented: $isPresenting){
            ImageSelector(uiImage: $uiImage, isPresenting:  $isPresenting, sourceType: $sourceType)
                .onDisappear{
                    if uiImage != nil {
                        imageClassifierObject.detect(uiImage: uiImage!)
                    }
                }
            
        }
        
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(imageClassifierObject: ImageRecognizer())
    }
}
