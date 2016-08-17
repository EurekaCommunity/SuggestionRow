//
//  SuggestionRow.swift
//
//  Adapted from Mathias Claassen 4/14/16 by Hélène Martin 8/11/16
//
//

import Foundation
import Eureka

protocol SuggestionRowProtocol {
    var filterFunction: ((String) -> [String])! { get set }
    func setSuggestions(text: String)
}

/// Generic suggestion row superclass that defines how to get a list of suggestions based on user input.
public class _SuggestionRow<Cell: SuggestionCell where Cell.Value == String>: FieldRow<String, Cell>, SuggestionRowProtocol {
    var filterFunction: ((String) -> [String])!

    required public init(tag: String?) {
        super.init(tag: tag)

        displayValueFor = { value in
            return value
        }
    }

    func setSuggestions(text: String) {
        self.cell.suggestions = filterFunction(text)
        self.cell.reload()
    }
}

/// Row that lets the user choose a suggested option from a list shown in the inputAccessoryView.
public final class SuggestionAccessoryRow: _SuggestionRow<SuggestionCollectionCell<SuggestionCollectionViewCell>>, RowType {
    required public init(tag: String?) {
        super.init(tag: tag)
    }
}

/// Row that lets the user choose a suggestion option from a table below the row.
public final class SuggestionTableRow: _SuggestionRow<SuggestionTableCell<SuggestionTableViewCell>>, RowType {
    required public init(tag: String?) {
        super.init(tag: tag)
    }
}