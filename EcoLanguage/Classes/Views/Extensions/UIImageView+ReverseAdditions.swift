import UIKit

extension UIImageView {
    
    func flipImage() {
        if (!self.layoutReversed) {
            self.transform = CGAffineTransform(scaleX: -1, y: 1)
        } else {
            self.transform = CGAffineTransform(scaleX: 1, y: 1)
        }
        
    }
    
    public override func reverseHorizontalConstraint(animated: Bool) -> Void {
        self.flipImage()
        super.reverseHorizontalConstraint(animated: animated)
    }
}
