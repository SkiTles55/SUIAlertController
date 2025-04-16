//
//  Configuration.swift
//  SUIAlertControllerSamples
//
//  Created by Dmitry Khudyakov on 16.04.2025.
//

import UIKit

protocol Configuration: CaseIterable, Equatable {
    var title: String { get }
    
    func getView(selectionChanged: ((Self) -> Void)?) -> UIView
}

enum AlertStyle: Configuration {
    case alert
    case actionSheet
    
    var title: String {
        "Alert style"
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
}

enum NetworkImageType: Configuration {
    case png
    case gif
    
    var title: String {
        "Network image type"
    }
}

extension Configuration {
    func getView(selectionChanged: ((Self) -> Void)?) -> UIView {
        let stackView = UIStackView.createStackBlock()
        let selectorsStack = UIStackView.createStackBlock()
        
        let label = UILabel()
        label.text = title
        stackView.addArrangedSubview(label)
        
        for type in Self.allCases {
            let button = RadioButton()
            button.setTitle(String(describing: type), for: .normal)
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
