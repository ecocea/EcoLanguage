import UIKit

open class EcoUILabel : UILabel, EcoContentLanguageDelegate{
    
    private var textKey : String?;
    
    override open var text: String? {
        get{
            return super.text;
        }
        set{
            if newValue == nil || newValue!.isEmpty {
                self.textKey = nil;
                super.text = newValue;
            }
            else{
                self.textKey = newValue;
                super.text = newValue?.localized;
            }
        }
    }
    
    // MARK: Content Language Change Management
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.textKey = self.text;
        self.text = self.textKey;
        EcoContentLanguageManager.subscribeToContentLanguageChanges(object: self);
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        self.textKey = self.text;
        self.text = self.textKey;
        EcoContentLanguageManager.subscribeToContentLanguageChanges(object: self);
    }
    
    deinit {
        EcoContentLanguageManager.unsubscribeToContentLanguageChanges(object: self);
    }
    
    // MARK : Content Language Delegate
    
    func didContentLanguageChange(notification: NSNotification) -> Void{
        guard self.textKey != nil else{
            return;
        }
        self.text = self.textKey;
    }
    
    
}
