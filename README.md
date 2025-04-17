# SUIAlertController
### Extended UIAlertController with ability show images and other custom content

![Sample project GIF](/screenshots/1.PNG?raw=true)

### Show UIImage in SUIAlertController
![UIImage in SUIAlertController](/screenshots/uiimage_in_alert.png?raw=true)
```
    func showAlert() {
        let controller = SUIAlertController(title: "Title",
                                            message: "Message",
                                            preferredStyle: .alert)
        controller.addContentView(UIImageView(image: UIImage(named: "your_image")))
        controller.addAction(.init(title: "OK", style: .cancel))
        present(controller, animated: true)
    }
```

### Show image from url (with GIF support) in SUIAlertController
![image from url (with GIF support) in SUIAlertController](/screenshots/network_image_in_alert.png?raw=true)
```
    func showAlert() {
        let controller = SUIAlertController(title: "Title",
                                            message: "Message",
                                            preferredStyle: .alert)
        controller.addContentView(imageUrl: "your_url", placeholderImage: UIImage(named: "image_if_loading_failed"))
        controller.addAction(.init(title: "OK", style: .cancel))
        present(controller, animated: true)
    }
```

### Show custom UIView in SUIAlertController
![custom UIView in SUIAlertController](/screenshots/custom_view_in_alert.png?raw=true)
```
class CustomAlertContentView: UIStackView, SContentView {
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
```
```
    func showAlert() {
        let controller = SUIAlertController(title: "Title",
                                            message: "Message",
                                            preferredStyle: .alert)
        controller.addContentView(CustomAlertContentView())
        controller.addAction(.init(title: "OK", style: .cancel))
        present(controller, animated: true)
    }
```
