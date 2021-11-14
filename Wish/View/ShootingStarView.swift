import UIKit

class ShootingStarPath: UIView {
    
    override func draw(_ rect: CGRect) {
        let path = customPaath()
        
        path.lineWidth = 0
        path.stroke()
    }
    
    func customPaath() -> UIBezierPath {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: frame.width + 50, y: 100))
        
        let endPoint = CGPoint(x: -50, y: 200)
        let curvePoint = CGPoint(x: frame.width / 3, y: 150)
        path.addCurve(to: endPoint, controlPoint1: curvePoint, controlPoint2: curvePoint)
        
        return path
    }
    
    static func createStars(view: UIView) {
        
        for _ in 0 ..< 100 {
            let starPositionY = CGFloat.random(in: 0 ..< view.frame.size.height / 4)
            let starPositionX = CGFloat.random(in: 0 ..< view.frame.size.width )
            let starSize = CGFloat.random(in: 0.1 ..< 2)
            let starBlinkTime = Double.random(in: 5 ..< 20)
            
            let star = UIView()
            star.alpha = 1
            star.layer.cornerRadius = 1
            star.backgroundColor = .white
            star.frame = CGRect(x: starPositionX, y: starPositionY, width: starSize, height: starSize)
            view.addSubview(star)
            
            var shouldBlink = false
            
            Timer.scheduledTimer(withTimeInterval: starBlinkTime, repeats: true) { timer in
                shouldBlink.toggle()
                
                UIView.animate(withDuration: 1) {
                    star.alpha = shouldBlink ? 0 : 1
                }
            }
        }
    }
    
    static func createShootingStars(view: UIView) {
        
        let shootingStarPath = ShootingStarPath()
        shootingStarPath.frame = view.frame
        shootingStarPath.backgroundColor = .clear
        view.addSubview(shootingStarPath)
        
        let shootingStar = UIImageView()
        shootingStar.backgroundColor = .white
        shootingStar.layer.cornerRadius = 1
        shootingStar.frame.size = CGSize(width: 2, height: 2)
        view.addSubview(shootingStar)
        
        Timer.scheduledTimer(withTimeInterval: 60, repeats: true) { _ in
            let animation = CAKeyframeAnimation(keyPath: "position")
            
            animation.path = shootingStarPath.customPaath().cgPath
            animation.duration = 1
            animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
            
            shootingStar.layer.add(animation, forKey: nil)
        }
    }
}
