//
//  UIStackView+Extension.swift
//  SUIAlertControllerSamples
//
//  Created by Dmitry Khudyakov on 16.04.2025.
//

import UIKit

extension UIStackView {
    static func createStackBlock() -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = .init(top: 8, left: 8, bottom: 8, right: 8)
        stackView.layer.borderColor = UIColor.secondaryLabel.cgColor
        stackView.layer.borderWidth = 1
        stackView.layer.cornerRadius = 8
        return stackView
    }
}
