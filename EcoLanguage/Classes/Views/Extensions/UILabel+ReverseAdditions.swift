import UIKit

extension UILabel {
    
    public func fixTextAlignementAccordingToLangageDeviceOrientation() -> Void{
        if(self.textAlignment == .natural){
            if(!RTL()){
                self.textAlignment = .left
            }
            else{
                self.textAlignment = .right;
            }
        }
    }
    
    public override func reverseHorizontalConstraint(animated: Bool) -> Void{
        super.reverseHorizontalConstraint(animated: animated);
        self.fixTextAlignementAccordingToLangageDeviceOrientation()
        if(self.textAlignment == .left){
            self.textAlignment = .right
        }
        else if(self.textAlignment == .right){
            self.textAlignment = .left
        }
    }
}
