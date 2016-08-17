//
//  SuggestionCollectionViewCell.swift
//
//  Adapted from Mathias Claassen 4/14/16 by Hélène Martin 8/11/16
//
//

import Foundation
import Eureka


public protocol EurekaSuggestionCollectionViewCell {
    func setText(prediction: String)
    func sizeThatFits() -> CGSize
}

/// Default cell for the inputAccessoryView of the SuggestionRow
public class SuggestionCollectionViewCell: UICollectionViewCell, EurekaSuggestionCollectionViewCell {
    public var label = UILabel()
    override public init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    func initialize() {
        label.font = UIFont.systemFontOfSize(15)
        label.numberOfLines = 1
        label.minimumScaleFactor = 0
        label.adjustsFontSizeToFitWidth = true
        label.textColor = UIColor.whiteColor()
        label.backgroundColor = UIColor.blueColor()
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 5
        
        contentView.addSubview(label)
        contentView.backgroundColor = UIColor.whiteColor()
        label.translatesAutoresizingMaskIntoConstraints = false
        contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[label]|", options: [], metrics: nil, views: ["label": label]))
        contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[label]|", options: [], metrics: nil, views: ["label": label]))
    }
    
    public func setText(prediction: String) {
        label.text = "  \(prediction)"
    }
    
    public func sizeThatFits() -> CGSize {
        label.frame = CGRectMake(0, 0, 180, 30)
        label.sizeToFit()
        return CGSizeMake(label.frame.width + 8, 30)
    }
}