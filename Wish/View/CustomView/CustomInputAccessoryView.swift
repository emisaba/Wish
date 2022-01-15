import UIKit

protocol CustomInputAccessoryViewDelegate {
    func didTapSendButton(text: String)
}

class CustomInputAccessoryView: UIView {
    
    // MARK: - Properties
    
    public var delegate: CustomInputAccessoryViewDelegate?
    
    private lazy var inputTextView = createTextField()
    
    private let addListButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "list-add"), for: .normal)
        button.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(didTapAddListButton), for: .touchUpInside)
        button.contentEdgeInsets = UIEdgeInsets(top: 3, left: 3, bottom: 3, right: 3)
        return button
    }()
    
    private let blurView: UIVisualEffectView = {
        let blur = UIBlurEffect(style: .dark)
        let effectView = UIVisualEffectView(effect: blur)
        effectView.alpha = 0.5
        return effectView
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        autoresizingMask = .flexibleHeight
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        return .zero
    }
    
    // MARK: - Actions
    
    @objc func didTapAddListButton() {
        delegate?.didTapSendButton(text: inputTextView.text ?? "")
        
        inputTextView.resignFirstResponder()
        inputTextView.text = nil
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        addSubview(blurView)
        blurView.fillSuperview()
        
        addSubview(inputTextView)
        inputTextView.anchor(top: topAnchor,
                             left: leftAnchor,
                             bottom: safeAreaLayoutGuide.bottomAnchor,
                             right: rightAnchor,
                             paddingTop: 12,
                             paddingLeft: 12,
                             paddingBottom: 8,
                             paddingRight: 56,
                             height: 40)
        
        addSubview(addListButton)
        addListButton.anchor(right: rightAnchor,
                             paddingRight: 8)
        addListButton.setDimensions(height: 30, width: 40)
        addListButton.centerY(inView: inputTextView)
    }
    
    func createTextField() -> UITextField {
        let tf = UITextField()
        tf.font = .yomogi(size: 16)
        tf.layer.cornerRadius = 5
        tf.backgroundColor = .white
        tf.tintColor = .lightGray
        
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 6, height: 50))
        tf.leftView = leftView
        tf.leftViewMode = .always
        
        let attributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.black,
                                                         .font: UIFont.moonFlower(size: 24),
                                                         .kern: 2]
        tf.attributedPlaceholder = NSAttributedString(string: "Wish upon a star...", attributes: attributes)
        
        return tf
    }
}
