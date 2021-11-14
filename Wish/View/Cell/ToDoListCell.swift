import UIKit

protocol EditTableViewCellDelegate {
    func didTapCheckBox(checkedCell: Int)
}

class ToDoListCell: UITableViewCell {
    
    // MARK: - Properties
    
    var delegate: EditTableViewCellDelegate?
    
    var viewModel: toDoListViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            configureViewModel(viewModel: viewModel)
        }
    }
    
    private lazy var checkBox: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 5
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 3
        button.addTarget(self, action: #selector(didTapCheckBox), for: .touchUpInside)
        return button
    }()
    
    private let checkMark: UILabel = {
        let label = UILabel()
        label.text = "✓"
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 16)
        label.textAlignment = .center
        return label
    }()
    
    private let wishTextLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.textColor = .white
        label.font = .systemFont(ofSize: 20)
        label.numberOfLines = 0
        return label
    }()
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Actions
    
    @objc func didTapCheckBox() {
        checkMark.isHidden = false
        delegate?.didTapCheckBox(checkedCell: viewModel?.cellNumber ?? 0)
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        selectionStyle = .none
        
        contentView.addSubview(checkBox)
        checkBox.anchor(left: leftAnchor,
                            paddingLeft: 20)
        checkBox.centerY(inView: self)
        checkBox.setDimensions(height: 25, width: 25)
        
        contentView.addSubview(checkMark)
        checkMark.setDimensions(height: 25, width: 25)
        checkMark.centerY(inView: checkBox)
        checkMark.centerX(inView: checkBox)
        
        addSubview(wishTextLabel)
        wishTextLabel.anchor(left: checkBox.rightAnchor,
                     right: rightAnchor,
                     paddingLeft: 20,
                     paddingRight: 20)
        wishTextLabel.centerY(inView: self)
    }
    
    func configureViewModel(viewModel: toDoListViewModel) {
        wishTextLabel.text = viewModel.text
        checkMark.isHidden = viewModel.isChecked
    }
}
