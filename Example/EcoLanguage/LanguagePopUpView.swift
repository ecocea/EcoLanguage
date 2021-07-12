import UIKit
import EcoLanguage

class LanguagePopUpView: UIView {
    
    /*
     // Only override drawRect: if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func drawRect(rect: CGRect) {
     // Drawing code
     }
     */
    private var maxHeight = 7*44 // 7 cells max height

    @IBOutlet var contentView : UIView!
    @IBOutlet var tableView : UITableView!
    
    
    var languageArray : Array<String> = []
    
    override func awakeFromNib() {
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "tableViewCell")
        
        addLanguageToList()
        self.tableView.reloadData()
        self.showPopUp(animated: true)
    }

    
    func hidePopUp(animated : Bool, dismiss : Bool) {
        if (dismiss == true) {
            self.removeFromSuperview()
        }
    }
    
    func showPopUp(animated : Bool) {
        var height = Int(self.tableView.numberOfRows(inSection: 0)) * Int(self.tableView.rectForRow(at: IndexPath(row: 0, section: 0)).height)
        if (height > self.maxHeight) {
            height = self.maxHeight
        }
    }
    
    func addLanguageToList() {

        self.languageArray.append("en");
        self.languageArray.append("ar");
        self.languageArray.append("fr");
    }
}

extension LanguagePopUpView : UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let language = self.languageArray[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell")
        cell?.textLabel?.text = language
        cell?.selectionStyle = .none
        cell?.textLabel?.textAlignment = .center
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        let newLang = cell?.textLabel?.text
        
        if (newLang != EcoContentLanguageManager.sharedInstance.context.currentContentLanguage) {
            
            EcoContentLanguageManager.sharedInstance.context.currentContentLanguage =  newLang
            hidePopUp(animated: true, dismiss: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.languageArray.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
}
