//
//  Extention+UIViewController.swift
//  MultiScreenAewsApplicationAndDesign
//
//  Created by Fatih on 8.01.2024.
//

import UIKit


extension UIViewController {
    static var identifier: String {
        return String(describing: self)
    }
    static func instantiate() -> Self {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(identifier: identifier) as! Self
       
        
    }
}

