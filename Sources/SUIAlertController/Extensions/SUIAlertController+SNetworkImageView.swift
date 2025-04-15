//
//  SUIAlertController+SNetworkImageView.swift
//  SUIAlertController
//
//  Created by Dmitry Khudyakov on 15.04.2025.
//

import UIKit

extension SUIAlertController {
    public func addContentView(imageUrl: String?,
                               placeholderImage: UIImage?) {
        let imageView = SNetworkImageView(
            imageUrl: imageUrl,
            placeholderImage: placeholderImage,
            stateChanged: { [weak self] in
                self?.view.setNeedsLayout()
            }
        )
        addContentView(imageView)
    }
}
