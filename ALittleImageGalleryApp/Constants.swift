//
//  Constants.swift
//  ALittleImageGalleryApp
//
//  Created by Sumair Zamir on 15/11/2020.
//

import UIKit

enum FloatConstants {
    case standardSpacing
    case cellHeight
    case cellsPerRow
    case searchEntryDelay
    
    var value: CGFloat {
        switch self {
        case .standardSpacing:
            return 10
        case .cellHeight:
            return 150
        case .cellsPerRow:
            return 2
        case .searchEntryDelay:
            return 0.5
        }
    }
}

enum StringConstants {
    case specifiedSize
    case placeholderText
    
    var value: String {
        switch self {
        case .specifiedSize:
            return "Large Square"
        case .placeholderText:
            return "Enter search text here"
        }
    }
}
