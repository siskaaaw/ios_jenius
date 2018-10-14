//
//  ExtensionUtils.swift
//  ios_assignment_jenius
//
//  Created by Yesiska Putri on 13/10/18.
//  Copyright © 2018 yesiska. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func setCircularView() {
        self.layer.cornerRadius = (self.frame.width) / 2
        self.layer.masksToBounds = true
        self.contentMode = .scaleAspectFill
        self.clipsToBounds = true
    }
}

extension UIImage {
    func resizeUIImage(targetSize: CGSize) -> UIImage {
        var finalWidth = targetSize.width
        var finalHeight = targetSize.height
        
        if (finalWidth > 0 && finalHeight > 0) {
            print("IMAGE_SIZE: \(size.width) - \(size.height)")
            
            let width = size.width
            let height = size.height
            
            var ratioImg : CGFloat!
            
            if width > height{
                ratioImg = height / width
                finalHeight = finalHeight * ratioImg
                
            }else{
                ratioImg = width / height
                if width > targetSize.width{
                    finalWidth = finalWidth * ratioImg
                }
            }
            
            print("IMAGE_SIZE_2: \(finalWidth) - \(finalHeight)")
            
            let newSize = CGSize(width: finalWidth, height: finalHeight)
            UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
            draw(in: CGRect(origin: CGPoint(x: 0, y: 0), size: newSize))
            let newImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return newImage!
            
        } else {
            return self
        }
    }
}
