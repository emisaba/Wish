import UIKit
import AVFoundation

class WishFeedController: HomeViewController {
    
    // MARK: - Properties
    
    private let cellIdentifier = "cellIdentifier"
    
    private lazy var wishFeed: UITableView = {
        let tv = UITableView()
        tv.dataSource = self
        tv.register(WishFeedCell.self, forCellReuseIdentifier: cellIdentifier)
        tv.backgroundColor = .clear
        tv.separatorStyle = .none
        tv.rowHeight = view.frame.height / 6
        tv.allowsSelection = false
        return tv
    }()
    
    private lazy var editButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemPink
        button.layer.cornerRadius = 30
        button.addTarget(self, action: #selector(didTapEditButton), for: .touchUpInside)
        return button
    }()
    
    private var wishes = [Wish]() {
        didSet { wishFeed.reloadData() }
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchWishes()
        AudioPlayer.startMusic()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        configureUI()
    }
    
    // MARK: - API
    
    func fetchWishes() {
        WishService.fetchWishes { wishes in
            self.wishes = wishes
        }
    }
    
    // MARK: - Action
    
    @objc func didTapEditButton() {
        
        let vc = MyWishViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: false)
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        
        view.addSubview(wishFeed)
        wishFeed.anchor(top: view.topAnchor,
                         left: view.leftAnchor,
                         bottom: view.bottomAnchor,
                         right: view.rightAnchor)
        
        view.addSubview(editButton)
        editButton.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                          right: view.rightAnchor,
                          paddingTop: 10,
                          paddingRight: 10)
        editButton.setDimensions(height: 60, width: 60)
    }
}

// MARK: - UITableViewDataSource

extension WishFeedController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wishes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! WishFeedCell
        cell.backgroundColor = .clear
        cell.delegate = self
        cell.wishFeedViewModel = WishFeedViewModel(wish: wishes[indexPath.row],
                                                   rowHeight: view.frame.height / 5,
                                                   rowNumber: RowNumber.allCases[indexPath.row])
        return cell
    }
}

// MARK: - TableViewCellDelegate

extension WishFeedController: TableViewCellDelegate {
    func reload() {
        wishFeed.reloadData()
    }
}
