//
//  objectRecognitionApp_ML_App.swift
//  objectRecognitionApp(ML)
//
//  Created by Stefano  on 23/06/22.
//

import SwiftUI

@main
struct objectRecognitionApp_ML_App: App {
    var body: some Scene {
        WindowGroup {
            ContentView(imageClassifierObject: ImageRecognizer())
        }
    }
}
