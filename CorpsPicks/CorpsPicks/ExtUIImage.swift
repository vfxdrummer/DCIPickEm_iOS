//
//  ExtensionUIImage.swift
//  Earbits Radio
//
//  Created by James Tan on 11/23/15.
//  Copyright © 2015 Earbits. All rights reserved.
//

import UIKit

extension UIImage {
  
  func grayScaleImage() -> UIImage {
    let imageRect = CGRectMake(0, 0, self.size.width, self.size.height);
    let colorSpace = CGColorSpaceCreateDeviceGray();
    
    let width = UInt(self.size.width)
    let height = UInt(self.size.height)
    let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.None.rawValue)
    
    let context = CGBitmapContextCreate(nil, Int(width), Int(height), 8, 0, colorSpace, bitmapInfo.rawValue);
    CGContextDrawImage(context, imageRect, self.CGImage!);
    
    let imageRef = CGBitmapContextCreateImage(context);
    let newImage = UIImage(CGImage: imageRef!)
    return newImage
  }
  
  static var emptyImage : UIImage {
    return UIImage(named:"no_profile_pic.jpg")!
  }
  static var noAlbumImage : UIImage {
    return  UIImage(named:"emptyAlbum.jpg")!
  }

}
