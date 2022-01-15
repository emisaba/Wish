import UIKit

class MyWishViewController: HomeViewController {
    
    // MARK: - Properties
    
    private let cellIdentifier = "cellIdentifier"
    
    private lazy var toDoList: UITableView = {
        let tv = UITableView()
        tv.dataSource = self
        tv.register(ToDoListCell.self, forCellReuseIdentifier: cellIdentifier)
        tv.backgroundColor = .clear
        tv.separatorStyle = .none
        tv.rowHeight = 60
        tv.contentInset = UIEdgeInsets(top: 70, left: 0, bottom: 10, right: 0)
        tv.alpha = 0
        return tv
    }()
    
    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "close").withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = .white
        button.contentEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        button.addTarget(self, action: #selector(didTapCloseButton), for: .touchUpInside)
        button.alpha = 0
        return button
    }()
    
    private lazy var customInputAccessoryView: CustomInputAccessoryView = {
        let view = CustomInputAccessoryView(frame: CGRect(x: 0, y: 0,
                                                          width: view.frame.width,
                                                          height: 50))
        view.delegate = self
        return view
    }()
    
    private let fireWorks = FireWorksView()
    
    private var wishes = [Wish]() {
        didSet { toDoList.reloadData() }
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchWishes()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        becomeFirstResponder()
        configureUI()
    }
    
    override var inputAccessoryView: UIView? {
        return customInputAccessoryView
    }
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    // MARK: - API
    
    func fetchWishes() {
        WishService.fetchWishes { wishes in
            self.wishes = wishes
        }
    }
    
    func uploadWishes() {
        WishService.uploadWishes(wishes: wishes) { error in
            
            if let error = error {
                print("fail to upload: \(error.localizedDescription)")
                return
            }
            self.closeToDoListView()
        }
    }
    
    // MARK: - Action
    
    @objc func didTapCloseButton() {
        uploadWishes()
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        
        view.addSubview(fireWorks)
        fireWorks.frame = CGRect(x: 0, y: view.frame.height - 320, width: 0, height: 0)
        fireWorks.center.x = view.frame.width / 2
        fireWorks.alpha = 0
        
        view.addSubview(toDoList)
        toDoList.anchor(top: view.topAnchor,
                        left: view.leftAnchor,
                        bottom: view.safeAreaLayoutGuide.bottomAnchor,
                        right: view.rightAnchor, paddingBottom: 55)
        
        view.addSubview(closeButton)
        closeButton.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                           right: view.rightAnchor,
                           paddingTop: 0,
                           paddingRight: 28)
        closeButton.setDimensions(height: 30, width: 30)
        
        UIView.animate(withDuration: 0.25) {
            self.toDoList.alpha = 1
            self.closeButton.alpha = 1
        }
    }
    
    func launchFireWorks() {
        
        UIView.animate(withDuration: 1) {
            self.fireWorks.alpha = 1
            
        } completion: { _ in
            UIView.animate(withDuration: 1, delay: 3) {
                self.fireWorks.alpha = 0
            }
        }
    }
    
    func closeToDoListView() {
        
        UIView.animate(withDuration: 0.25) {
            self.toDoList.alpha = 0
            self.closeButton.alpha = 0
            
        } completion: { _ in
            self.dismiss(animated: false, completion: nil)
        }
    }
}

// MARK: - UITableViewDataSource

extension MyWishViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wishes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ToDoListCell
        cell.viewModel = toDoListViewModel(wish: wishes[indexPath.row], cellNumber: indexPath.row)
        cell.backgroundColor = .clear
        cell.delegate = self
        return cell
    }
}

// MARK: - CustomInputAccessoryViewDelegate

extension MyWishViewController: CustomInputAccessoryViewDelegate {
    
    func didTapSendButton(text: String) {
        
        let data: [String: Any] = ["wish": text, "isChecked": false]
        let wish = Wish(id: nil, dictionary: data)
        
        wishes.insert(wish, at: 0)
        toDoList.reloadData()
    }
}

// MARK: - EditTableViewCellDelegate

extension MyWishViewController: EditTableViewCellDelegate {
    
    func didTapCheckBox(checkedCell: Int) {
        wishes[checkedCell].isChecked.toggle()
        
        if wishes[checkedCell].isChecked {
            launchFireWorks()
        }
    }
}
