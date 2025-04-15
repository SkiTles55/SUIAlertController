//
//  SContentView.swift
//  SUIAlertController
//
//  Created by Dmitry Khudyakov on 15.04.2025.
//

import UIKit

public protocol SContentView: UIView {
    func getSize(with maximalWidth: CGFloat) -> CGSize
}
