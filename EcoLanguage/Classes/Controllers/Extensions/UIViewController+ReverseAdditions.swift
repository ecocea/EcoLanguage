import UIKit

extension UIViewController{
    
    func callLayoutNeeded() {
        self.view.updateConstraintsIfNeeded()
        self.view.layoutIfNeeded()
    }
    
    func reverseLayoutIfNeeded() -> Void{
        if (EcoContentLanguageManager.sharedInstance.context.currentLanguageDirection == .leftToRight) {
            if (self.view.layoutReversed == true) {
                self.view.reverseHorizontalConstraint(animated: EcoContentLanguageManager.sharedInstance.context.reverseAnimated)
                self.callLayoutNeeded()
            }
        } else if (EcoContentLanguageManager.sharedInstance.context.currentLanguageDirection == .rightToLeft) {
            if (self.view.layoutReversed == false) {
                self.view.reverseHorizontalConstraint(animated: EcoContentLanguageManager.sharedInstance.context.reverseAnimated)
                self.callLayoutNeeded()
            }
        }

        self.view.removeMarkerOnConstraint()
    }
}
