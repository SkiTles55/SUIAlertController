//
//  Configuration.swift
//  SUIAlertControllerSamples
//
//  Created by Dmitry Khudyakov on 16.04.2025.
//

import UIKit

protocol Configuration: CaseIterable, Equatable {
    var title: String { get }
    var selectorTitle: String { get }
    
    func getView(selectionChanged: ((Self) -> Void)?) -> UIView
}

enum AlertStyle: Configuration {
    case alert
    case actionSheet
    
    var title: String {
        "Alert style"
    }
    
    var selectorTitle: String {
        switch self {
        case .alert:
            return "Alert"
        case .actionSheet:
            return "Action sheet"
        }
    }
    
    var style: UIAlertController.Style {
        switch self {
        case .alert:
            return .alert
        case .actionSheet:
            return .actionSheet
        }
    }
}

enum ContentType: Configuration {
    case image
    case networkImage
    
    var title: String {
        "Content type"
    }
    
    var selectorTitle: String {
        switch self {
        case .image:
            return "Image from assets"
        case .networkImage:
            return "Image from network"
        }
    }
}

enum NetworkImageType: Configuration {
    case png
    case gif
    
    var title: String {
        "Network image type"
    }
    
    var selectorTitle: String {
        switch self {
        case .png:
            return "PNG"
        case .gif:
            return "GIF"
        }
    }
}

extension Configuration {
    func getView(selectionChanged: ((Self) -> Void)?) -> UIView {
        let stackView = UIStackView.createStackBlock()
        let selectorsStack = UIStackView.createStackBlock()
        
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.text = title
        stackView.addArrangedSubview(label)
        
        for type in Self.allCases {
            let button = RadioButton()
            button.setTitle(type.selectorTitle, for: .normal)
            button.addAction(.init(handler: { _ in
                setType(type, button, selectionChanged)
            }), for: .touchUpInside)
            button.isSelected = type == self
            selectorsStack.addArrangedSubview(button)
        }
        
        stackView.addArrangedSubview(selectorsStack)
        return stackView
    }
    
    private func setType(_ type: Self,
                         _ sender: RadioButton,
                         _ selectionChanged: ((Self) -> Void)?) {
        for case let button as RadioButton in (sender.superview as? UIStackView)?.arrangedSubviews ?? [] {
            button.isSelected = (button == sender)
        }
        selectionChanged?(type)
    }
}
