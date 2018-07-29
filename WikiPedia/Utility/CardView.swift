

import UIKit
class CardView: UIView {
    override func layoutSubviews() {
        layer.cornerRadius = 10.0
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        layer.shadowRadius = 6.0
        layer.shadowOpacity = 0.4
        layer.masksToBounds = false
//        layer.backgroundColor = UIColor.white.cgColor
        updateShadowPath()
}
    func updateShadowPath() {
        layer.shadowPath = UIBezierPath(roundedRect: layer.bounds, cornerRadius: layer.cornerRadius).cgPath
    }
}
