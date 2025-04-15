//
//  ViewController.swift
//  SUIAlertControllerSamples
//
//  Created by Dmitry Khudyakov on 15.04.2025.
//

import UIKit
import SUIAlertController

class ViewController: UIViewController {
    private var stackView: UIStackView?
    
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
        
        self.stackView = stackView
        
        addButton(title: "Alert with image view", action: #selector(showAlertWithImageView))
        addButton(title: "Action sheet with image view", action: #selector(showActionSheetWithImageView))
        
        addButton(title: "Alert with network png image", action: #selector(showAlertWithNetworkImageJPEG))
        addButton(title: "Action sheet with network png image", action: #selector(showActionSheetWithNetworkImageJPEG))
    }
    
    private func addButton(title: String, action: Selector) {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.addTarget(self, action: action, for: .touchUpInside)
        stackView?.addArrangedSubview(button)
    }
    
    @objc private func showAlertWithImageView() {
        showSUIAlertControllerWithImageView(preferredStyle: .alert)
    }
    
    @objc private func showActionSheetWithImageView() {
        showSUIAlertControllerWithImageView(preferredStyle: .actionSheet)
    }
    
    private func showSUIAlertControllerWithImageView(preferredStyle: UIAlertController.Style) {
        let controller = getSUIAlertController(title: "Test alert with image view",
                                               message: "Sample message in alert with image view",
                                               preferredStyle: preferredStyle)
        let imageView = UIImageView(image: UIImage(named: "Image"))
        controller.addContentView(imageView)
        present(controller, animated: true)
    }
    
    private let jpegImageUrl = "https://images.squarespace-cdn.com/content/v1/63139bb1e1a1a078e071f30c/040fa157-d86e-44d3-95a3-950218793a47/FI_EddYXoAAv1GL.jpeg"
    
    @objc private func showAlertWithNetworkImageJPEG() {
        showSUIAlertControllerWithNetworkImage(imageUrl: jpegImageUrl,
                                               type: "JPEG",
                                               preferredStyle: .alert)
    }
    
    @objc private func showActionSheetWithNetworkImageJPEG() {
        showSUIAlertControllerWithNetworkImage(imageUrl: jpegImageUrl,
                                               type: "JPEG",
                                               preferredStyle: .actionSheet)
    }
    
    private func showSUIAlertControllerWithNetworkImage(imageUrl: String?,
                                                        type: String,
                                                        preferredStyle: UIAlertController.Style) {
        let controller = getSUIAlertController(title: "Test alert with network image \(type)",
                                               message: "Sample message in alert with image view",
                                               preferredStyle: preferredStyle)
        controller.addContentView(imageUrl: imageUrl, placeholderImage: UIImage(systemName: "exclamationmark.triangle"))
        present(controller, animated: true)
    }
    
    private func getSUIAlertController(title: String?,
                                       message: String?,
                                       preferredStyle: UIAlertController.Style) -> SUIAlertController {
        let controller = SUIAlertController(title: title,
                                            message: message,
                                            preferredStyle: preferredStyle)
        controller.addAction(.init(title: "OK", style: .cancel))
        return controller
    }
}
