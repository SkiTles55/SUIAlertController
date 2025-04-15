//
//  SNetworkImageView.swift
//  SUIAlertController
//
//  Created by Dmitry Khudyakov on 15.04.2025.
//

import MobileCoreServices
import UIKit

class SNetworkImageView: UIView, SContentView {
    private var imageView = UIImageView()
    private let loaderView = UIActivityIndicatorView()
    private let loaderSize = CGSize(width: 30, height: 30)
    private var downloadTask: URLSessionDataTask?
    
    private let imageUrl: String?
    private let placeholderImage: UIImage?
    private let stateChanged: (() -> Void)?
    
    private enum State {
        case isLoading
        case loadingCompleted
        case loadingFailed
    }
    
    private var state: State = .isLoading {
        didSet {
            stateChanged?()
        }
    }
    
    public override var contentMode: UIView.ContentMode {
        didSet {
            imageView.contentMode = contentMode
        }
    }
    
    init(imageUrl: String?,
         placeholderImage: UIImage?,
         stateChanged: (() -> Void)?) {
        self.imageUrl = imageUrl
        self.placeholderImage = placeholderImage
        self.stateChanged = stateChanged
        super.init(frame: .zero)
        
        contentMode = .scaleAspectFit
        addSubview(imageView)
        addSubview(loaderView)
        loaderView.startAnimating()
        loadImage()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = bounds
        loaderView.frame = bounds
    }
    
    deinit {
        downloadTask?.cancel()
    }
    
    public func getSize(with maximalWidth: CGFloat) -> CGSize {
        switch state {
        case .isLoading:
            return loaderSize
        case .loadingCompleted, .loadingFailed:
            return imageView.getSize(with: maximalWidth)
        }
    }
    
    private func loadImage() {
        guard let imageUrl = imageUrl,
              let url = URL(string: imageUrl) else {
            updateImageView(data: nil)
            return
        }
        
        downloadTask = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self,
                  let data = data,
                  error == nil else {
                DispatchQueue.main.async {
                    self?.updateImageView(data: nil)
                }
                return
            }
            
            DispatchQueue.main.async {
                self.updateImageView(data: data)
            }
        }
        downloadTask?.resume()
    }
    
    private func updateImageView(data: Data?) {
        loaderView.stopAnimating()
        if let data {
            setImage(from: data)
        } else {
            imageView.image = placeholderImage
        }
        state = data != nil ? .loadingCompleted : .loadingFailed
    }
    
    private func setImage(from data: Data) {
        if isGIF(data: data) {
            setupGIFAnimation(data: data)
        } else if let image = UIImage(data: data) {
            imageView.image = image
        }
    }
    
    private func isGIF(data: Data) -> Bool {
        guard let source = CGImageSourceCreateWithData(data as CFData, nil),
              let type = CGImageSourceGetType(source) else { return false }
        return UTTypeConformsTo(type, kUTTypeGIF)
    }
    
    private func setupGIFAnimation(data: Data) {
        guard let imageSource = CGImageSourceCreateWithData(data as CFData, nil) else { return }
        let frameCount = CGImageSourceGetCount(imageSource)
        
        var images = [UIImage]()
        var totalDuration: TimeInterval = 0
        
        for i in 0..<frameCount {
            if let cgImage = CGImageSourceCreateImageAtIndex(imageSource, i, nil) {
                let image = UIImage(cgImage: cgImage)
                images.append(image)
                
                if let properties = CGImageSourceCopyPropertiesAtIndex(imageSource, i, nil) as? [String: Any],
                   let gifProperties = properties[kCGImagePropertyGIFDictionary as String] as? [String: Any],
                   let delayTime = gifProperties[kCGImagePropertyGIFDelayTime as String] as? TimeInterval {
                    totalDuration += delayTime
                }
            }
        }
        
        imageView.animationImages = images
        imageView.animationDuration = totalDuration
        imageView.animationRepeatCount = 0
        imageView.startAnimating()
    }
}
