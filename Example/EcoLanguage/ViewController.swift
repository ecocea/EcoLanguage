import UIKit
import EcoLanguage

class ViewController: EcoUIViewController {
    
    @IBOutlet weak var titleLabel: EcoUILabel!
    @IBOutlet weak var textField: EcoUITextField!
    @IBOutlet weak var button: EcoUIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        updateLocalizedStrings()
    }
    
    override func updateLocalizedStrings() {
        titleLabel.text = NSLocalizedString(key: "LABEL")
        textField.text = NSLocalizedString(key: "TEXTFIELD")
        button.setTitle(NSLocalizedString(key: "BUTTON"), for: .normal)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func rightTopButtonClicked() {
        let view = LanguagePopUpView.loadFromNib()
        view.frame = self.view.frame
        self.view.addSubview(view)
        if view.layoutReversed != self.view.layoutReversed {
            view.reverseHorizontalConstraint(animated: true)
        }
    }
    
}

