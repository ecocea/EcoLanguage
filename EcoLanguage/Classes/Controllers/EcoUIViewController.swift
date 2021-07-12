import UIKit

/* Every view controller inherit from EcoUIViewController to handle RTL and changing language easily */
open class EcoUIViewController : UIViewController, EcoContentLanguageDelegate {

    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.view.layoutIfNeeded()
        self.reverseLayoutIfNeeded()
        self.updateLocalizedStrings()
    }
    
    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    // MARK: Content Language Change Management
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        EcoContentLanguageManager.subscribeToContentLanguageChanges(object: self);
    }
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        EcoContentLanguageManager.subscribeToContentLanguageChanges(object: self);
    }
    
    deinit {
        EcoContentLanguageManager.unsubscribeToContentLanguageChanges(object: self);
    }
    
    open func updateLocalizedStrings() -> Void {
    }
    
    // MARK: Content Language Delegate
    
    func didContentLanguageChange(notification: NSNotification) {
        self.reverseLayoutIfNeeded()
        self.updateLocalizedStrings()
    }

}
