import UIKit

extension UIView {
    
    private struct AssociatedKeys {
        static var LayoutReversed = "eco_LayoutReversed"
    }
    
    public var layoutReversed : Bool{
        get{
            let number = objc_getAssociatedObject(self, &AssociatedKeys.LayoutReversed) as? NSNumber
            guard (number != nil) else { return false }
            return number!.boolValue
        }
        set{
            let number : NSNumber? = NSNumber(value: newValue);
            if let number = number {
                objc_setAssociatedObject(
                    self,
                    &AssociatedKeys.LayoutReversed,
                    number,
                    .OBJC_ASSOCIATION_RETAIN_NONATOMIC
                )
            }
        }
    }
    
    public func removeMarkerOnConstraint() {
        for subview in self.subviews {
            subview.removeMarkerOnConstraint()
        }
        for cstr in self.constraints {
            cstr.identifier = ""
        }
    }
    
    @objc
    public func reverseHorizontalConstraint(animated: Bool) -> Void{
        for subview in self.subviews {
            subview.reverseHorizontalConstraint(animated: animated)
        }
        let constraints : Array = self.constraints
        for cstr in constraints {
            let firstAttrNew : NSLayoutConstraint.Attribute = self.inverseAttributeHorizontal(attribute: cstr.firstAttribute)
            let secondAttrNew : NSLayoutConstraint.Attribute = self.inverseAttributeHorizontal(attribute: cstr.secondAttribute)
            if (cstr.identifier == "NEW") {
                break
            }
            if (firstAttrNew != cstr.firstAttribute || secondAttrNew != cstr.secondAttribute){
                
                let cstrNew : NSLayoutConstraint = NSLayoutConstraint(item: cstr.firstItem as Any, attribute: firstAttrNew, relatedBy: cstr.relation, toItem: cstr.secondItem, attribute: secondAttrNew, multiplier: cstr.multiplier, constant: -cstr.constant)
                self.removeConstraint(cstr)
                self.addConstraint(cstrNew)
                cstrNew.identifier = "NEW"
                
                
            }
            
        }
        self.updateConstraintsIfNeeded()
        
        self.layoutReversed = !self.layoutReversed
    }
    
    private func inverseAttributeHorizontal(attribute: NSLayoutConstraint.Attribute) -> NSLayoutConstraint.Attribute{
        switch(attribute){
        case .left:
            return NSLayoutConstraint.Attribute.right
        case .right:
            return NSLayoutConstraint.Attribute.left
        case .leftMargin:
            return NSLayoutConstraint.Attribute.rightMargin
        case .rightMargin:
            return NSLayoutConstraint.Attribute.leftMargin
        case .leading :
            return NSLayoutConstraint.Attribute.trailing
        case .leadingMargin :
            return NSLayoutConstraint.Attribute.trailingMargin
        case .trailing :
            return NSLayoutConstraint.Attribute.leading
        case .trailingMargin :
            return NSLayoutConstraint.Attribute.leadingMargin
        default:
            return attribute
        }
    }
}
