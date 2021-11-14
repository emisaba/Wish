import UIKit

protocol TableViewCellDelegate {
    func reload()
}

class WishFeedCell: UITableViewCell {
    
    // MARK: - Poperties
    
    var delegate: TableViewCellDelegate?
    
    var wishFeedViewModel: WishFeedViewModel? {
        didSet {
            guard let viewModal = wishFeedViewModel else { return }
            configureUI(viewModel: viewModal)
        }
    }
    
    private let feedLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 20)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.alpha = 0
        return label
    }()
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        guard let viewModal = wishFeedViewModel else { return }
        let labelHeight: CGFloat = 80
        let sidePadding: CGFloat = 20
        
        feedLabel.frame = CGRect(x: sidePadding,
                                 y: viewModal.rowHeight - labelHeight,
                                 width: frame.width - sidePadding * 2,
                                 height: labelHeight)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    func configureUI(viewModel: WishFeedViewModel) {
        
        let labelHeight: CGFloat = 80
        let sidePadding: CGFloat = 20
        
        addSubview(feedLabel)
        feedLabel.frame = CGRect(x: sidePadding,
                                 y: viewModel.rowHeight - labelHeight,
                                 width: frame.width - sidePadding * 2,
                                 height: labelHeight)
        feedLabel.center.x = self.center.x
        feedLabel.textAlignment = viewModel.wishTextAlignment
        feedLabel.text = viewModel.wishText
        
        animateCell(viewModel: viewModel)
    }
    
    func animateCell(viewModel: WishFeedViewModel) {
        
        UIView.animate(withDuration: 6, delay: viewModel.animationDelaySec) {
            self.feedLabel.frame.origin.y = -10
            let transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.feedLabel.transform = transform
        }
        
        UIView.animate(withDuration: 2, delay: viewModel.animationDelaySec) {
            self.feedLabel.alpha = 1
            
        } completion: { _ in
            UIView.animate(withDuration: 2, delay: 4) {
                self.feedLabel.alpha = 0
                
            } completion: { _ in
                let transform = CGAffineTransform(scaleX: 1, y: 1)
                self.feedLabel.transform = transform
                
                if viewModel.animationDelaySec == 24 {
                    self.delegate?.reload()
                }
            }
        }
    }
}
