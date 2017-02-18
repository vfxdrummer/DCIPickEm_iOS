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
    let imageRect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height);
    let colorSpace = CGColorSpaceCreateDeviceGray();
    
    let width = UInt(self.size.width)
    let height = UInt(self.size.height)
    let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.none.rawValue)
    
    let context = CGContext(data: nil, width: Int(width), height: Int(height), bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: bitmapInfo.rawValue);
    context?.draw(self.cgImage!, in: imageRect);
    
    let imageRef = context?.makeImage();
    let newImage = UIImage(cgImage: imageRef!)
    return newImage
  }
  
  static var emptyImage : UIImage {
    return UIImage(named:"no_profile_pic.jpg")!
  }
  static var noAlbumImage : UIImage {
    return  UIImage(named:"emptyAlbum.jpg")!
  }

}
