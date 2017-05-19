//
//  ExtUIViewController.swift
//  CorpsPicks
//
//  Created by Timothy Brandt on 5/18/17.
//  Copyright © 2017 Tim Brandt. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func goToTab(index:Int) {
        if let tabBarVC = self.navigationController!.viewControllers.first as? UITabBarController {
            tabBarVC.selectedIndex = index
        }
    }
    
}
