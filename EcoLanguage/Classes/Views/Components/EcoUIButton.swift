import UIKit


func ==(lhs: UIControl.State, rhs: UIControl.State) -> Bool {
    return lhs.rawValue == rhs.rawValue;
}

extension UIControl.State : Hashable{
    public var hashValue : Int{
        return Int(self.rawValue);
    }
}


open class EcoUIButton : UIButton, EcoContentLanguageDelegate{
    
    
    private var titleKeysByState : Dictionary<UIControl.State,String?>? = [UIControl.State:String?]()
    
    override open func setTitle(_ title: String?, for state: UIControl.State) {
        
        if (title == nil || title!.isEmpty) {
            self.titleKeysByState![state] = nil
            super.setTitle(title, for: state)
        }
        else{
            self.titleKeysByState![state] = title;
            super.setTitle(title!.localized, for: state)
        }
    }
    
    // MARK: Content Language Change Management
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.titleKeysByState![UIControl.State.normal] = self.titleLabel!.text;
        self.setTitle(self.titleLabel!.text, for: UIControl.State.normal);
        EcoContentLanguageManager.subscribeToContentLanguageChanges(object: self);
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.titleKeysByState![.normal] = self.title(for: .normal)
        self.setTitle(self.title(for: .normal), for: .normal);
        EcoContentLanguageManager.subscribeToContentLanguageChanges(object: self);
    }
    
    deinit {
        EcoContentLanguageManager.unsubscribeToContentLanguageChanges(object: self);
    }
    
    // MARK : Content Language Delegate
    
    func didContentLanguageChange(notification: NSNotification) -> Void{
        guard self.titleKeysByState != nil else{
            return;
        }
        for (state, titleKey) in self.titleKeysByState! {
            guard (titleKey != nil) else { continue }
            self.setTitle(titleKey,for:  state);
        }
        if self.contentHorizontalAlignment != .center {
            if EcoContentLanguageManager.sharedInstance.context.currentLanguageDirection == NSLocale.LanguageDirection.rightToLeft {
                self.contentHorizontalAlignment = .right
            } else {
                self.contentHorizontalAlignment = .left
            }
        }
        
        if EcoContentLanguageManager.sharedInstance.context.currentLanguageDirection == NSLocale.LanguageDirection.rightToLeft {
            self.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
            self.titleLabel!.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
            self.imageView!.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        } else {
            self.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            self.titleLabel!.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            self.imageView!.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }
        
    }
    
    override open var intrinsicContentSize: CGSize {
        let s = super.intrinsicContentSize
        return CGSize(width: s.width + self.titleEdgeInsets.left + self.titleEdgeInsets.right,
                      height: s.height + self.titleEdgeInsets.top + self.titleEdgeInsets.bottom)
    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        var frame = self.titleLabel?.frame
        frame?.size.height = self.bounds.size.height
        frame?.origin.y = self.titleEdgeInsets.top
        self.titleLabel!.frame = frame!
    }
}

