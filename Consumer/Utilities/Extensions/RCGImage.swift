//
//  RCGImage.swift
//  Consumer
//
//  Created by Vladislav Zagorodnyuk on 7/30/16.
//  Copyright © 2016 Vlad Z. All rights reserved.
//

import UIKit

extension UIImage {
    
    class func imagesWithSpriteSheet(name: String = "pokemonIcons", range: NSRange = NSMakeRange(0, Int.max), spriteSize: CGSize = CGSize(width: 65.0, height: 65.0))-> [UIImage] {
        
        var resultArray = [UIImage]()
        
        // Check if main image exists
        guard let mainImage = UIImage(named: name) else {
            
            return resultArray
        }
        
        let spriteSheet = mainImage.CGImage
        
        let width = CGImageGetWidth(spriteSheet)
        let height = CGImageGetHeight(spriteSheet)
        
        let maxI = width / Int(spriteSize.width)
        
        var startI = 0
        var startJ = 0
        var length = 0
        
        let startPosition = range.location
        
        // Extracting initial I & J values from range info
        if startPosition != 0 {
            for k in 1...maxI {
                
                let d = k * maxI
                
                if d/startPosition == 1 {
                    startI = maxI - (d % startPosition)
                    break
                }
                else if d/startPosition > 1 {
                    startI = startPosition
                    break
                }
                
                startJ = startJ + 1
            }
        }
        
        var positionX = startI * Int(spriteSize.width)
        var positionY = startJ * Int(spriteSize.height)
        var isReady = false
        
        while positionY < height {
            while positionX < width {
                
                let sprite = CGImageCreateWithImageInRect(spriteSheet, CGRect(x: CGFloat(positionX), y: CGFloat(positionY), w: spriteSize.width, h: spriteSize.height))
                
                if let sprite = sprite {
                    resultArray.append(UIImage(CGImage: sprite))
                }
                
                length = length + 1
                
                if length == range.length {
                    isReady = true
                    break
                }
                
                positionX = positionX + Int(spriteSize.width)
            }
            
            if isReady {
                break
            }
            
            positionX = 0
            positionY = positionY + Int(spriteSize.height)
        }
        
        return resultArray
    }
}
