//
//  ViewController.swift
//  SUIAlertControllerSamples
//
//  Created by Dmitry Khudyakov on 15.04.2025.
//

import UIKit
import SUIAlertController

class ViewController: UIViewController {
    private var alertStyle: AlertStyle = .alert
    private var alertContentType: ContentType = .image
    private var networkImageType: NetworkImageType = .jpeg
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -40),
            stackView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor)
        ])
        
        let alertStyleConfiguration = alertStyle.getView() { [weak self] type in
            self?.alertStyle = type
        }
        stackView.addArrangedSubview(alertStyleConfiguration)
        
        let networkImageTypeConfiguration = networkImageType.getView() { [weak self] type in
            self?.networkImageType = type
        }
        networkImageTypeConfiguration.isHidden = true
        let contentViewConfiguration = alertContentType.getView() { [weak self] type in
            self?.alertContentType = type
            networkImageTypeConfiguration.isHidden = type != .networkImage
        }
        stackView.addArrangedSubview(contentViewConfiguration)
        stackView.addArrangedSubview(networkImageTypeConfiguration)
        
        
        let button = UIButton(type: .system)
        button.setTitle("Show alert", for: .normal)
        button.addTarget(self, action: #selector(showAlert), for: .touchUpInside)
        stackView.addArrangedSubview(button)
    }
    
    @objc private func showAlert() {
        let controller = SUIAlertController(title: "Test alert",
                                            message: "Message in test alert",
                                            preferredStyle: alertStyle.style)
        switch alertContentType {
        case .customView:
            controller.addContentView(CustomAlertContentView())
        case .image:
            controller.addContentView(UIImageView(image: UIImage.assetImage))
        case .networkImage:
            switch networkImageType {
            case .jpeg:
                controller.addContentView(imageUrl: ImageUrls.jpeg, placeholderImage: UIImage.triangle)
            case .gif:
                controller.addContentView(imageUrl: ImageUrls.gif, placeholderImage: UIImage.triangle)
            }
        }
        controller.addAction(.init(title: "OK", style: .cancel))
        present(controller, animated: true)
    }
}
