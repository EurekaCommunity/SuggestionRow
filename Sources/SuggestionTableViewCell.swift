//
//  SuggestionTableViewCell.swift
//
//  Adapted from Mathias Claassen 4/14/16 by Hélène Martin 8/11/16
//
//

import Foundation
import Eureka

public protocol EurekaSuggestionTableViewCell {
    associatedtype S: SuggestionValue

    func setupForValue(_ value: S)
}

/// Default cell for the table of the SuggestionTableCell
open class SuggestionTableViewCell<T: SuggestionValue>: UITableViewCell, EurekaSuggestionTableViewCell {
    public typealias S = T
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initialize()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    func initialize() {
        textLabel?.font = .systemFont(ofSize: 16)
        textLabel?.minimumScaleFactor = 0.8
        textLabel?.adjustsFontSizeToFitWidth = true
        textLabel?.textColor = .blue
        contentView.backgroundColor = .white
    }
    
    open func setupForValue(_ value: T) {
        textLabel?.text = value.suggestionString
    }
}
