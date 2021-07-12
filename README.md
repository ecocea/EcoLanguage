# EcoLanguage
## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## How does it work ?


To change the language, just pass the new language to `currentLanguage` of the `EcoContentLanguageManager`.

Example
```swift
EcoContentLanguageManager.sharedInstance.context.currentContentLanguage =  "en"
```


To enable the RTL modification on the fly, use:
+ EcoUIButton
+ EcoUILabel
+ EcoUITextField


To change the text value, your controller must inherit from `EcoViewController`
Then you have to override the `udpdateLocalizedStrings()` function.

Example:
```swift
override func updateLocalizedStrings() {
    titleLabel.text = NSLocalizedString(key: "LABEL")
    textField.text = NSLocalizedString(key: "TEXTFIELD")
    button.setTitle(NSLocalizedString(key: "BUTTON"), for: .normal)
}
```

The `NSLocalizedString` function will first try to find the text value using the datasource (protocol: `EcoContentLanguageManagerDataSource`).
If the datasource is nil, the `i18n.strings` files will be used. The strings file will be the one contained in .lproj folder prefixed by the currentLanguage value (en.lproj, fr.lprog, etc..)



## Author

Asuard, Ecocea

## License

EcoLanguage is available under the MIT license. See the LICENSE file for more info.
