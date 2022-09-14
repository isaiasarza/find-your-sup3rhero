//
//  ImageUtils.swift
//  FindYourSup3rHero
//
//  Created by Isaias Arza on 14/09/2022.
//

import Foundation
import UIKit
class ImageUtils{
    static func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage? {
        let size = image.size
            
            let widthRatio  = targetSize.width  / size.width
            let heightRatio = targetSize.height / size.height
            
            // Figure out what our orientation is, and use that to form the rectangle
            var newSize: CGSize
            if(widthRatio > heightRatio) {
                newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
            } else {
                newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
            }
            
            // This is the rect that we've calculated out and this is what is actually used below
            let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
            
            // Actually do the resizing to the rect using the ImageContext stuff
            UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
            image.draw(in: rect)
            let newImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            return newImage!
    }
    
    static func fetchImage(URLAddress: String) async -> Any?{
        
        if let url = URL(string: URLAddress), let imageData = try? Data(contentsOf: url) {
            if let loadedImage = UIImage(data: imageData) {
                    
                let resizedImage: UIImage? = self.resizeImage(image: loadedImage, targetSize: CGSize(width: 120 , height: 120))
                return resizedImage
            }
        }
        return ""
    }
}
