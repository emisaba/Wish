import UIKit

protocol CustomInputAccessoryViewDelegate {
    func didTapSendButton(text: String)
}

class CustomInputAccessoryView: UIView {
    
    // MARK: - Properties
    
    var delegate: CustomInputAccessoryViewDelegate?
    
    let inputTextView: UITextView = {
        let tv = UITextView()
        tv.font = UIFont.systemFont(ofSize: 16)
        tv.isScrollEnabled = false
        tv.layer.cornerRadius = 5
        return tv
    }()
    
    private let sendButton: UIButton = {
        let button = UIButton()
        button.setTitle("send", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 14)
        button.addTarget(self, action: #selector(didTapSendButton), for: .touchUpInside)
        return button
    }()
    
    let placeholderLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.text = "Wish upon a star..."
        label.textColor = .lightGray
        return label
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
    
    @objc func didTapSendButton() {
        delegate?.didTapSendButton(text: inputTextView.text ?? "")
        
        inputTextView.resignFirstResponder()
        inputTextView.text = nil
        placeholderLabel.isHidden = false
    }
    
    @objc func handleTextInputChange() {
        placeholderLabel.isHidden = !inputTextView.text.isEmpty
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        addSubview(blurView)
        blurView.fillSuperview()
        
        addSubview(sendButton)
        sendButton.anchor(top: topAnchor,
                          right: rightAnchor,
                          paddingTop: 4,
                          paddingRight: 8)
        sendButton.setDimensions(height: 50, width: 50)
        
        addSubview(inputTextView)
        inputTextView.anchor(top: topAnchor,
                                    left: leftAnchor,
                                    bottom: safeAreaLayoutGuide.bottomAnchor,
                                    right: sendButton.leftAnchor,
                                    paddingTop: 12,
                                    paddingLeft: 12,
                                    paddingBottom: 8,
                                    paddingRight: 8)
        
        addSubview(placeholderLabel)
        placeholderLabel.anchor(left: inputTextView.leftAnchor, paddingLeft: 4)
        placeholderLabel.centerY(inView: inputTextView)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(handleTextInputChange),
                                               name: UITextView.textDidChangeNotification,
                                               object: nil)
    }
}
