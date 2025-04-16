//
//  CustomAlertContentView.swift
//  SUIAlertControllerSamples
//
//  Created by Dmitry Khudyakov on 16.04.2025.
//

import Foundation
import UIKit
import SUIAlertController

final class CustomAlertContentView: UIStackView, SContentView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        axis = .vertical
        spacing = 8
        isLayoutMarginsRelativeArrangement = true
        layoutMargins = .init(top: 8, left: 8, bottom: 8, right: 8)
        layer.borderColor = UIColor.secondaryLabel.cgColor
        layer.borderWidth = 1
        layer.cornerRadius = 8
        
        let label1 = UILabel()
        label1.font = UIFont.preferredFont(forTextStyle: .headline)
        label1.text = "Label1 headline"
        label1.textAlignment = .center
        addArrangedSubview(label1)
        
        let imageView = UIImageView(image: UIImage.triangle)
        imageView.contentMode = .scaleAspectFit
        addArrangedSubview(imageView)
        
        let label2 = UILabel()
        label2.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label2.text = "Label2 subheadline"
        label2.textAlignment = .center
        addArrangedSubview(label2)
        
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getSize(with maximalWidth: CGFloat) -> CGSize {
        let size = CGSize(width: maximalWidth, height: .leastNonzeroMagnitude)
        return systemLayoutSizeFitting(size,
                                       withHorizontalFittingPriority: .required,
                                       verticalFittingPriority: .fittingSizeLevel)
    }
}
