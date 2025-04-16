//
//  RadioButton.swift
//  SUIAlertControllerSamples
//
//  Created by Dmitry Khudyakov on 16.04.2025.
//

import UIKit

class RadioButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        setImage(UIImage(systemName: "circle"), for: .normal)
        setImage(UIImage(systemName: "largecircle.fill.circle"), for: .selected)
        contentHorizontalAlignment = .left
        titleEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0)
    }
}
