//
//  DetailPickerView.swift
//  TV Show
//
//  Created by Hao Kim on 1/9/21.
//

import Foundation

enum DetailPickerView {
    case isVisible
    case isHidden
    
    static var presentType: DetailPickerView = .isHidden {
        didSet {
            switch presentType {
            case .isVisible:
                break
            case .isHidden:
                break
            }
        }
    }
}
