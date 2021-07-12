import UIKit

extension UIView {
    
    static func loadFromNib() -> UIView {
        let nibName = "\(self)".split{$0 == "."}.map(String.init).last!
        let nib = UINib(nibName: nibName, bundle: nil)
        return nib.instantiate(withOwner: self, options: nil).first as! UIView
    }
}
