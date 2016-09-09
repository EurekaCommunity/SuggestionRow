//
//  SuggestionCell.swift
//
//  Adapted from Mathias Claassen 4/14/16 by Hélène Martin 8/11/16
//
//

import Foundation
import UIKit
import Eureka

/// General suggestion cell. Create a subclass or use SuggestionCollectionCell or SuggestionTableCell.
public class SuggestionCell<T: SuggestionValue>: _FieldCell<T>, CellType {
    let cellReuseIdentifier = "Eureka.SuggestionCellIdentifier"
    var suggestions: [T]?
    
    required public init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    override public func setup() {
        super.setup()
        textField.autocorrectionType = .No
        textField.autocapitalizationType = .Sentences
    }
    
    //MARK: UITextFieldDelegate
    public override func textFieldDidBeginEditing(textField: UITextField) {
        formViewController()?.beginEditing(self)
        formViewController()?.textInputDidBeginEditing(textField, cell: self)
        textField.selectAll(nil)
        
        if let text = textField.text {
            setSuggestions(text)
        }
    }
    
    public override func textFieldDidChange(textField: UITextField) {
        super.textFieldDidChange(textField)
        if let text = textField.text {
            setSuggestions(text)
        }

    }
    
    public override func textFieldDidEndEditing(textField: UITextField) {
        formViewController()?.endEditing(self)
        formViewController()?.textInputDidEndEditing(textField, cell: self)
        textField.text = row.displayValueFor?(row.value)
    }

    func setSuggestions(string: String) {}
    
    func reload() {}
}
