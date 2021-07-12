import UIKit

open class EcoUITabBarController: UITabBarController, EcoContentLanguageDelegate {

    private var languageDirection = EcoContentLanguageManager.sharedInstance.context.currentLanguageDirection
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override open func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
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
        self.reverseItemsIfNeeded()
        self.updateLocalizedStrings()
    }
    
    
    //MARK: Private
    private func reverseItemsIfNeeded() {
        let direction = EcoContentLanguageManager.sharedInstance.context.currentLanguageDirection
        if direction != self.languageDirection, direction != .unknown {
            self.languageDirection = direction
            self.viewControllers = self.viewControllers?.reversed()
        }
    }

}
