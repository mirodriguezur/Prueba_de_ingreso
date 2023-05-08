//
//  UIViewExtensions.swift
//  UsersApp
//
//  Created by Michael Alexander Rodriguez Urbina on 7/05/23.
//

import Foundation
import UIKit

extension UIView {
    func grid( _ radious: CGFloat = 1) {
        self.layer.cornerRadius = radious
        self.clipsToBounds = true
    }
    
    func addBorder(color: UIColor, width: CGFloat) {
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = width
    }
}
