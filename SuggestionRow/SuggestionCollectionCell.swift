//
//  SuggestionCollectionCell.swift
//
//  Adapted from Mathias Claassen 4/14/16 by Hélène Martin 8/11/16
//
//

import Foundation
import UIKit

let accessoryViewHeight = CGFloat(40)

public class SuggestionCollectionCell<T: SuggestionValue, CollectionViewCell: UICollectionViewCell where CollectionViewCell: EurekaSuggestionCollectionViewCell, CollectionViewCell.S == T>: SuggestionCell<T>, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    /// callback that can be used to customize the appearance of the UICollectionViewCell in the inputAccessoryView
    public var customizeCollectionViewCell: (CollectionViewCell -> Void)?
    
    /// UICollectionView that acts as inputAccessoryView.
    public lazy var collectionView: UICollectionView? = {
        let collectionView = UICollectionView(frame: CGRectMake(0, 0, self.contentView.frame.width, accessoryViewHeight), collectionViewLayout: self.collectionViewLayout)
        collectionView.autoresizingMask = .FlexibleWidth
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.whiteColor()
        collectionView.registerClass(CollectionViewCell.self, forCellWithReuseIdentifier: self.cellReuseIdentifier)
        return collectionView
    }()
    
    public var collectionViewLayout: UICollectionViewLayout = {
        var layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .Horizontal
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 5
        layout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5)
        return layout
    }()
    
    required public init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    public override var inputAccessoryView: UIView? {
        return collectionView
    }
    
    public override func setup() {
        super.setup()
        
    }
    
    override func reload() {
        collectionView?.reloadData()
    }

    override func setSuggestions(string: String) {
        suggestions = (row as? _SuggestionRow<T, SuggestionCollectionCell>)?.filterFunction(string)
        reload()
    }
    
    //MARK: UICollectionViewDelegate and Datasource
    public func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return suggestions?.count ?? 0
    }
    
    public func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellReuseIdentifier, forIndexPath: indexPath) as! CollectionViewCell
        if let suggestion = suggestions?[indexPath.row] {
            cell.setupForValue(suggestion)
        }
        customizeCollectionViewCell?(cell)
        return cell
    }
    
    public func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if let suggestion = suggestions?[indexPath.row] {
            row.value = suggestion
            cellResignFirstResponder()
        }
    }
    
    public func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let cell = CollectionViewCell(frame: CGRectZero)
        if let suggestion = suggestions?[indexPath.row] {
            cell.setupForValue(suggestion)
        }
        return cell.sizeThatFits()
    }
    
    public func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
}
