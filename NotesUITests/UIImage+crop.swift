//
//  UIImage+crop.swift
//  NotesUITests
//
//  Created by Aleksei Permiakov on 18.04.2023.
//

import UIKit

extension UIImage {
    var removingStatusBar: UIImage? {
        guard let cgImage = cgImage else {
            return nil
        }
        
        let yOffset = 54 * scale // status bar height on iphone 14 Pro
        let rect = CGRect(
            x: 0,
            y: Int(yOffset),
            width: cgImage.width,
            height: cgImage.height - Int(yOffset)
        )
        
        if let croppedCGImage = cgImage.cropping(to: rect) {
            return UIImage(cgImage: croppedCGImage, scale: scale, orientation: imageOrientation)
        }
        
        return nil
    }
}
