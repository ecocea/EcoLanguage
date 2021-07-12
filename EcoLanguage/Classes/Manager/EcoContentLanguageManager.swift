import UIKit


let kNotificationContentLanguageChanged : String = "kNotificationContentLanguageChanged"

let kContentLanguageChangeAnimated : Bool = true

public func RTL() -> Bool{
    return NSLocale.characterDirection(forLanguage: NSLocale.preferredLanguages[0]) == NSLocale.LanguageDirection.rightToLeft
}

protocol EcoContentLanguageManagerDataSource {
    func localizedString(key: String,language : String?) -> String?
}

public class EcoContentLanguageManager: NSObject {
    
    // MARK: Context
    public class Context{
        public var currentContentLanguage : String? = "Base" {
            didSet {
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: kNotificationContentLanguageChanged),object:  self.currentContentLanguage)
            }
        }
        
        var reverseAnimated : Bool = kContentLanguageChangeAnimated
        var layoutReversed : Bool = false
        
        var currentLanguageDirection : NSLocale.LanguageDirection {
            get {
                if (self.currentContentLanguage != nil) {
                    return NSLocale.characterDirection(forLanguage: (self.currentContentLanguage)!)
                } else {
                    return NSLocale.LanguageDirection.unknown
                }
            }
        }
    }
    
    // MARK: Singleton pattern implementation
    public static let sharedInstance = EcoContentLanguageManager()
    
    private override init (){
        super.init()
    }
    
    // MARK: instance member
    var dataSource : EcoContentLanguageManagerDataSource?
    public var context : Context = Context()
    
    // MARK: class methods
    
    static func subscribeToContentLanguageChanges(object: AnyObject)  -> Void{
        if let object = object as? EcoContentLanguageDelegate {
            NotificationCenter.default.addObserver(object, selector: #selector(EcoContentLanguageDelegate.didContentLanguageChange(notification:)), name: NSNotification.Name(rawValue: kNotificationContentLanguageChanged), object: nil)
        }
        else{
            fatalError("Object need to conform to protocol ContentLanguageDelegate !")
        }
    }
    
    static func unsubscribeToContentLanguageChanges(object: AnyObject) -> Void{
        if let object = object as? EcoContentLanguageDelegate {
            NotificationCenter.default.removeObserver(object,name: NSNotification.Name(rawValue: kNotificationContentLanguageChanged),object: nil)
        }
        else{
            fatalError("Object need to conform to protocol ContentLanguageDelegate !")
        }
    }
}

public func NSLocalizedString(key: String) -> String{
    guard (EcoContentLanguageManager.sharedInstance.dataSource != nil) else {
        var strGuard = key
        if let path = Bundle.main.path(forResource: EcoContentLanguageManager.sharedInstance.context.currentContentLanguage, ofType: "lproj") {
            if let languageBundle = Bundle(path: path) {
                languageBundle.localizedString(forKey: key, value: key, table: "i18n")
                strGuard = languageBundle.localizedString(forKey: key, value: key, table: "i18n")
            }
        }
        return strGuard
    }
    
    var str = EcoContentLanguageManager.sharedInstance.dataSource!.localizedString(key: key, language: EcoContentLanguageManager.sharedInstance.context.currentContentLanguage)
    if (str == nil) {
        let path = Bundle.main.path(forResource: "Base", ofType: "lproj")
        let languageBundle = Bundle(path: path!)
        str = languageBundle!.localizedString(forKey: key, value: key, table: "i18n")
        if (str == nil) {
            str = key
        }
    }
    return (str != nil) ? str! : key
}

public extension String {
    var localized : String{
        get{
            return NSLocalizedString(key: self)
        }
    }
}

@objc protocol EcoContentLanguageDelegate{
    func didContentLanguageChange(notification: NSNotification) -> Void
}
