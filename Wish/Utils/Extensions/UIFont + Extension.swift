import UIKit

extension UIFont {
    
    static func moonFlower(size: CGFloat) -> UIFont {
        return UIFont(name: "Moon Flower", size: size) ?? .systemFont(ofSize: size)
    }
    
    static func yomogi(size: CGFloat) -> UIFont {
        return UIFont(name: "Yomogi-Regular", size: size) ?? .systemFont(ofSize: size)
    }
}
