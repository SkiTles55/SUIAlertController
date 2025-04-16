//
//  SUIAlertController.swift
//  SUIAlertController
//
//  Created by Dmitry Khudyakov on 15.04.2025.
//

import Foundation
import UIKit

open class SUIAlertController: UIAlertController {
    private var contentView: SContentView?
    private var contentViewWidthConstraint: NSLayoutConstraint?
    private var contentViewHeightConstraint: NSLayoutConstraint?
    private var initialMessage: String?
    
    private var contentWidth: CGFloat {
        view.frame.width - 32
    }
    
    public enum ContentPosition {
        case bellowMessage
        case aboveMessage
        
        var extendedHeight: CGFloat {
            switch self {
            case .bellowMessage:
                return 16
            case .aboveMessage:
                return 16
            }
        }
    }
    
    public var contentPosition: ContentPosition = .bellowMessage
    
    open override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        guard let messageLabel = view.findLabel(with: message),
              messageLabel.frame != .zero,
              let contentView else { return }
        
        resetMessageIfNeeded()
        
        let textHeight = getHeight(of: messageLabel, text: message)
        var finalTextHeight = textHeight
        disableConstraints()
        let contentSize = contentView.getSize(with: contentWidth)
        while finalTextHeight < textHeight + contentSize.height + contentPosition.extendedHeight {
            switch contentPosition {
            case .bellowMessage:
                self.message = (message ?? "") + "\n"
            case .aboveMessage:
                self.message = "\n" + (message ?? "")
            }
            finalTextHeight = getHeight(of: messageLabel, text: message)
        }
        
        updateConstraints(contentView, contentSize)
    }
    
    public func addContentView(_ contentView: SContentView) {
        guard let messageLabel = view.findLabel(with: message) else {
            assertionFailure("unable to find message label")
            return
        }
        self.contentView = contentView
        
        var superView = messageLabel.superview
        if let effectView = superView?.superview as? UIVisualEffectView {
            superView = effectView.superview
        }
        superView?.addSubview(contentView)
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        let contentSize = contentView.getSize(with: contentWidth)
        updateConstraints(contentView, contentSize)
        NSLayoutConstraint.activate([
            createPositionConstraint(contentView, messageLabel),
            contentView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            contentViewWidthConstraint,
            contentViewHeightConstraint
        ].compactMap { $0 })
    }
    
    private func resetMessageIfNeeded() {
        if initialMessage == nil {
            initialMessage = message
        } else {
            message = initialMessage
        }
    }
    
    private func disableConstraints() {
        contentViewWidthConstraint?.isActive = false
        contentViewHeightConstraint?.isActive = false
    }
    
    private func getHeight(of label: UILabel, text: String?) ->  CGFloat {
        label.text = text
        let size = CGSize(width: contentWidth, height: UIView.layoutFittingCompressedSize.height)
        return label.systemLayoutSizeFitting(size,
                                             withHorizontalFittingPriority: .required,
                                             verticalFittingPriority: .fittingSizeLevel).height
    }
    
    private func updateConstraints(_ contentView: SContentView, _ contentSize: CGSize) {
        contentViewWidthConstraint = contentView.widthAnchor.constraint(equalToConstant: contentSize.width)
        contentViewWidthConstraint?.isActive = true
        
        contentViewHeightConstraint = contentView.heightAnchor.constraint(equalToConstant: contentSize.height)
        contentViewHeightConstraint?.isActive = true
    }
    
    private func createPositionConstraint(_ contentView: SContentView,
                                          _ messageLabel: UILabel) -> NSLayoutConstraint {
        switch contentPosition {
        case .bellowMessage:
            return contentView.bottomAnchor.constraint(equalTo: messageLabel.bottomAnchor)
        case .aboveMessage:
            return contentView.topAnchor.constraint(equalTo: messageLabel.topAnchor,
                                                    constant: 8)
        }
    }
}

private extension UIView {
    func findLabel(with text: String?) -> UILabel? {
        for view in subviews {
            if let label = view as? UILabel,
               label.text == text {
                return label
            } else if let innerLabel = view.findLabel(with: text) {
                return innerLabel
            }
        }
        return nil
    }
}
