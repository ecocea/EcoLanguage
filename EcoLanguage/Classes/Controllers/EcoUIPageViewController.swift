import UIKit

open class EcoUIPageViewController: UIPageViewController, EcoContentLanguageDelegate {
    
    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.view.layoutIfNeeded()
        self.reverseLayoutIfNeeded()
        self.updateLocalizedStrings()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        EcoContentLanguageManager.subscribeToContentLanguageChanges(object: self);
    }
    
    deinit {
        EcoContentLanguageManager.unsubscribeToContentLanguageChanges(object: self);
    }
    
    open func updateLocalizedStrings() -> Void {
    }
    
    // MARK: Content Language Delegate
    
    open func didContentLanguageChange(notification: NSNotification) {
        self.reverseLayoutIfNeeded()
        self.updateLocalizedStrings()
    }
}
