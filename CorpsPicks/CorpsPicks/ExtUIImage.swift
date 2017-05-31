//
//  ExtensionUIImage.swift
//  Earbits Radio
//
//  Created by James Tan on 11/23/15.
//  Copyright © 2015 Earbits. All rights reserved.
//

import UIKit

extension UIImage {
  
  func maskWithColor(color: UIColor) -> UIImage? {
    let maskImage = cgImage!
    
    let width = size.width
    let height = size.height
    let bounds = CGRect(x: 0, y: 0, width: width, height: height)
    
    let colorSpace = CGColorSpaceCreateDeviceRGB()
    let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)
    let context = CGContext(data: nil, width: Int(width), height: Int(height), bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: bitmapInfo.rawValue)!
    
    context.clip(to: bounds, mask: maskImage)
    context.setFillColor(color.cgColor)
    context.fill(bounds)
    
    if let cgImage = context.makeImage() {
      let coloredImage = UIImage(cgImage: cgImage)
      return coloredImage
    } else {
      return nil
    }
  }
  
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
