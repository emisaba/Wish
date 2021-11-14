import UIKit

class HomeViewController: UIViewController {

    // MARK: - Properties
    
    private let backgroundImage: UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "tokyo")
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    private let blurView: UIVisualEffectView = {
        let blur = UIBlurEffect(style: .dark)
        let effectView = UIVisualEffectView(effect: blur)
        effectView.alpha = 0.5
        return effectView
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(backgroundImage)
        backgroundImage.fillSuperview()
        
        view.addSubview(blurView)
        blurView.fillSuperview()
        
        ShootingStarPath.createStars(view: view)
        ShootingStarPath.createStars(view: view)
    }
}
