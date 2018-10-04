//
//  SuggestionTableCell.swift
//
//  Adapted from Mathias Claassen 4/14/16 by Hélène Martin 8/11/16
//
//

import Foundation
import UIKit

open class SuggestionTableCell<T, TableViewCell: UITableViewCell>: SuggestionCell<T>, UITableViewDelegate, UITableViewDataSource where TableViewCell: EurekaSuggestionTableViewCell, TableViewCell.S == T {
    
    /// callback that can be used to customize the table cell.
    public var customizeTableViewCell: ((TableViewCell) -> Void)?
    
    public var tableView: UITableView?

    required public init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    open override func setup() {
        super.setup()
        tableView = UITableView(frame: CGRect.zero, style: .plain)
        tableView?.tableFooterView = UIView(frame: CGRect.zero)
        tableView?.autoresizingMask = .flexibleHeight
        tableView?.isHidden = true
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.backgroundColor = UIColor.white
        tableView?.register(TableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
    }
    
    open func showTableView() {
        if let controller = formViewController() {
            if tableView?.superview == nil {
                controller.view.addSubview(tableView!)
            }
            let frame = controller.tableView?.convert(self.frame, to: controller.view) ?? self.frame
            let maxSuggestionRowHeight = (row as? _SuggestionRow<SuggestionTableCell>)?.maxSuggestionRows ?? 5
            tableView?.frame = CGRect(x: 0, y: frame.origin.y + frame.height, width: contentView.frame.width, height: 44 * CGFloat(maxSuggestionRowHeight))
            tableView?.isHidden = false
        }
    }
    
    open func hideTableView() {
        tableView?.isHidden = true
    }
    
    override func reload() {
        tableView?.reloadData()
    }

    override func setSuggestions(_ string: String) {
        if let filterFunction = (row as? _SuggestionRow<SuggestionTableCell>)?.filterFunction {
            suggestions = filterFunction(string)
            reload()
        }
        if let asyncFilterFunction = (row as? _SuggestionRow<SuggestionTableCell>)?.asyncFilterFunction {
            asyncFilterFunction(string, { (values) in
                self.suggestions = values
                self.reload()
            })
        }
    }
    
    open override func textFieldDidChange(_ textField: UITextField) {
        super.textFieldDidChange(textField)
        if textField.text?.isEmpty == false {
            showTableView()
        }
    }

    open override func textFieldDidEndEditing(_ textField: UITextField) {
        super.textFieldDidEndEditing(textField)
        hideTableView()
    }
    
    //MARK: UITableViewDelegate and Datasource
    open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return suggestions?.count ?? 0
    }
    
    open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! TableViewCell
        if let prediction = suggestions?[(indexPath as NSIndexPath).row] {
            cell.setupForValue(prediction)
        }
        customizeTableViewCell?(cell)
        return cell
    }
    
    open func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let prediction = suggestions?[(indexPath as NSIndexPath).row] {
            row.value = prediction
            _ = cellResignFirstResponder()
        }
    }
    
    open func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}
