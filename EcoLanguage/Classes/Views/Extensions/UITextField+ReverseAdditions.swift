import UIKit

extension UITextField {
    
    public func fixTextAlignementAccordingToLangageDeviceOrientation() -> Void{
        if (self.textAlignment == .natural) {
            if (!self.layoutReversed) {
                self.textAlignment = .left
            }
            else {
                self.textAlignment = .right
            }
        }
    }
    
    public override func reverseHorizontalConstraint(animated: Bool) -> Void{
        super.reverseHorizontalConstraint(animated: animated)
        self.fixTextAlignementAccordingToLangageDeviceOrientation()
        if (self.layoutReversed) {
            self.textAlignment = .right
        }
        else {
            self.textAlignment = .left
        }
    }
}
