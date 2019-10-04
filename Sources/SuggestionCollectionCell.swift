//
//  SuggestionCollectionCell.swift
//
//  Adapted from Mathias Claassen 4/14/16 by Hélène Martin 8/11/16
//
//

import Foundation
import UIKit

let accessoryViewHeight = CGFloat(40)

open class SuggestionCollectionCell<T, CollectionViewCell: UICollectionViewCell>: SuggestionCell<T>, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout where CollectionViewCell: EurekaSuggestionCollectionViewCell, CollectionViewCell.S == T {
    
    /// callback that can be used to customize the appearance of the UICollectionViewCell in the inputAccessoryView
    public var customizeCollectionViewCell: ((CollectionViewCell) -> Void)?
    
    /// UICollectionView that acts as inputAccessoryView.
    public lazy var collectionView: UICollectionView? = {
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: self.contentView.frame.width, height: accessoryViewHeight), collectionViewLayout: self.collectionViewLayout)
        collectionView.autoresizingMask = .flexibleWidth
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        if #available(iOS 13.0, *) {
            collectionView.backgroundColor = .systemBackground
        } else {
            collectionView.backgroundColor = .white
        }
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: self.cellReuseIdentifier)
        return collectionView
    }()
    
    public var collectionViewLayout: UICollectionViewLayout = {
        var layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 5
        layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        return layout
    }()
    
    required public init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    open override var inputAccessoryView: UIView? {
        return collectionView
    }
    
    open override func setup() {
        super.setup()
        
    }
    
    override func reload() {
        collectionView?.reloadData()
    }

    override func setSuggestions(_ string: String) {
        if let filterFunction = (row as? _SuggestionRow<SuggestionCollectionCell>)?.filterFunction {
            suggestions = filterFunction(string)
            reload()
        }
        if let asyncFilterFunction = (row as? _SuggestionRow<SuggestionCollectionCell>)?.asyncFilterFunction {
            asyncFilterFunction(string, { (values) in
                self.suggestions = values
                self.reload()
            })
        }
    }
    
    //MARK: UICollectionViewDelegate and Datasource
    open func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return suggestions?.count ?? 0
    }
    
    open func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseIdentifier, for: indexPath) as! CollectionViewCell
        if let suggestion = suggestions?[(indexPath as NSIndexPath).row] {
            cell.setupForValue(suggestion)
        }
        customizeCollectionViewCell?(cell)
        return cell
    }
    
    open func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let suggestion = suggestions?[(indexPath as NSIndexPath).row] {
            row.value = suggestion
            _ = cellResignFirstResponder()
        }
    }
    
    open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cell = CollectionViewCell(frame: CGRect.zero)
        if let suggestion = suggestions?[(indexPath as NSIndexPath).row] {
            cell.setupForValue(suggestion)
        }
        return cell.sizeThatFits()
    }
    
    open func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
}
