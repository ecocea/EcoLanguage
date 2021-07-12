import UIKit

open class EcoUITableViewController: UITableViewController, EcoContentLanguageDelegate {

    override open func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.view.layoutIfNeeded()
        self.reverseLayoutIfNeeded()
        self.updateLocalizedStrings()
    }

    override open func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        self.tableView.reloadData()
    }
    
    // MARK: Content Language Delegate
    
    func didContentLanguageChange(notification: NSNotification) {
        self.reverseLayoutIfNeeded()
        self.updateLocalizedStrings()
    }

    // MARK: - Table view data source

    override open func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

}
