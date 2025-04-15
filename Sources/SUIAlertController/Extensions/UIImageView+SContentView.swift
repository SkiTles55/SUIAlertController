//
//  UIImageView+SContentView.swift
//  SUIAlertController
//
//  Created by Dmitry Khudyakov on 15.04.2025.
//

import UIKit

extension UIImageView: SContentView {
    public func getSize(with maximalWidth: CGFloat) -> CGSize {
        guard let size = (animationImages?.first ?? image)?.size else {
            assertionFailure("unable to find image")
            return .zero
        }
        let aspectRatio = size.width / size.height
        
        if size.width > size.height {
            return CGSize(width: maximalWidth, height: maximalWidth / aspectRatio)
        } else {
            return CGSize(width: maximalWidth * aspectRatio, height: maximalWidth)
        }
    }
}
