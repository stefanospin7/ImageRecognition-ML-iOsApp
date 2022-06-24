//
//  ImageClassifier.swift
//  foodRecognitorApp
//
//  Created by Stefano  on 23/06/22.
//

import Foundation
import SwiftUI


class ImageRecognizer: ObservableObject {
    
    @Published private var objectClassifier = MyImageResearcher()
    
    var imageClass: String? {
        objectClassifier.results
    }
        
    // MARK: Intent(s)
    func detect(uiImage: UIImage) {
        guard let ciImage = CIImage (image: uiImage) else { return }
        objectClassifier.detect(ciImage: ciImage)
        
    }
        
}

