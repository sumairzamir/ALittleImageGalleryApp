//
//  Extensions.swift
//  ALittleImageGalleryApp
//
//  Created by Sumair Zamir on 15/11/2020.
//

import UIKit

extension UIView {
    
    func addMultipleSubviews(_ subviews: [UIView]) {
        for subview in subviews {
            addSubview(subview)
        }
    }
}
