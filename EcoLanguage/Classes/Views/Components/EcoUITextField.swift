import UIKit

open class EcoUITextField: UITextField, EcoContentLanguageDelegate {
    
    
    private var placeHolderKey : String?;
    
    /*
     placeholder string must be the localization key
     */
    override open var placeholder: String?{
        get{
            return super.placeholder
        }
        set{
            if (newValue != self.placeholder) {
                self.placeHolderKey = newValue
                super.placeholder = newValue!.localized
            }
        }
    }
    
    // MARK: Content Language Change Management
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.placeHolderKey = self.placeholder;
        self.placeholder = self.placeHolderKey;
        EcoContentLanguageManager.subscribeToContentLanguageChanges(object: self);
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.placeHolderKey = self.placeholder;
        self.placeholder = self.placeHolderKey;
        EcoContentLanguageManager.subscribeToContentLanguageChanges(object: self);
    }
    
    deinit {
        EcoContentLanguageManager.unsubscribeToContentLanguageChanges(object: self);
    }
    
    // MARK : Content Language Delegate
    
    func didContentLanguageChange(notification: NSNotification) -> Void{
        guard (placeHolderKey != nil) else { return }
        self.placeholder = self.placeHolderKey;
    }
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 4, dy: 0)
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 4, dy: 0)
    }
    
    override open func clearButtonRect(forBounds bounds:CGRect) -> CGRect {
        if (EcoContentLanguageManager.sharedInstance.context.currentLanguageDirection == NSLocale.LanguageDirection.rightToLeft &&  self.textAlignment != .right) || self.textAlignment == .right {
            return CGRect(bounds.origin.x + 15 - (bounds.size.width/2), bounds.origin.y, bounds.size.width, bounds.size.height)
        }
        
        return super.clearButtonRect(forBounds: bounds)
    }
    
}

extension CGRect{
    init(_ x:CGFloat,_ y:CGFloat,_ width:CGFloat,_ height:CGFloat) {
        self.init(x:x,y:y,width:width,height:height)
    }
    
}
