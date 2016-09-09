//
//  SuggestionRow.swift
//
//  Adapted from Mathias Claassen 4/14/16 by Hélène Martin 8/11/16
//
//

import Foundation
import Eureka

public protocol SuggestionValue: Equatable, InputTypeInitiable {
    var suggestionString: String { get }
}

/// Generic suggestion row superclass that defines how to get a list of suggestions based on user input.
public class _SuggestionRow<T: SuggestionValue, Cell: BaseCell
        where Cell: CellType, Cell: TextFieldCell, Cell: TypedCellType, Cell.Value == T>: FieldRow<T, Cell> {

    public var filterFunction: ((String) -> [T])!

    required public init(tag: String?) {
        super.init(tag: tag)

        displayValueFor = { value in
            return value?.suggestionString
        }
    }
}

/// Row that lets the user choose a suggested option from a list shown in the inputAccessoryView.
public final class SuggestionAccessoryRow<T: SuggestionValue>: _SuggestionRow<T, SuggestionCollectionCell<T, SuggestionCollectionViewCell<T>>>, RowType {
    required public init(tag: String?) {
        super.init(tag: tag)
    }
}

/// Row that lets the user choose a suggestion option from a table below the row.
public final class SuggestionTableRow<T: SuggestionValue>: _SuggestionRow<T, SuggestionTableCell<T, SuggestionTableViewCell<T>>>, RowType {
    required public init(tag: String?) {
        super.init(tag: tag)
    }
}