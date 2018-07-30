//
//  RMScrollView.swift
//
//  Created by Martin Rader on 30.07.18.
//  Copyright © 2018 Martin Rader. All rights reserved.
//

import UIKit

class RMScrollView: UIView {

    var contentView:RMScrollContentView?
    var scrollView:UIScrollView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    func commonInit() {
        
        //Create and add the ScrollView
        scrollView = UIScrollView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: self.frame.size))
        self.addSubview(scrollView)
        
        //Search the RMScrollContentView
        for subview in subviews {
            if let contentView = subview as? RMScrollContentView {
                self.contentView = contentView
                scrollView.addSubview(contentView)
            }
        }
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        
        //remove the outside constraints of RMScrollContentView
        for constraint in self.constraints {
            if (constraint.firstItem as? RMScrollContentView) != nil
            && (constraint.secondItem as? RMScrollView) != nil {
                removeConstraint(constraint)
            }
        }
        
        //set constraints for the scrollView
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        setTopBottomLeadingTrailingConstraint(firstItem: scrollView, secondItem: self)
        
        //set constraint for the contentView
        if let contentView = contentView {
            contentView.translatesAutoresizingMaskIntoConstraints = false
            setTopBottomLeadingTrailingConstraint(firstItem: contentView, secondItem: scrollView)
        } else {
            print("RMScrollView: no ContentView detected!")
        }
    }
    
    func setTopBottomLeadingTrailingConstraint(firstItem:UIView, secondItem:UIView) {
        let topConstraint = NSLayoutConstraint(item: firstItem, attribute: .top, relatedBy: .equal, toItem: secondItem, attribute: .top, multiplier: 1, constant: 0)
        let bottomConstraint = NSLayoutConstraint(item: firstItem, attribute: .bottom, relatedBy: .equal, toItem: secondItem, attribute: .bottom, multiplier: 1, constant: 0)
        let leadingConstraint = NSLayoutConstraint(item: firstItem, attribute: .leading, relatedBy: .equal, toItem: secondItem, attribute: .leading, multiplier: 1, constant: 0)
        let trailingConstraint = NSLayoutConstraint(item: firstItem, attribute: .trailing, relatedBy: .equal, toItem: secondItem, attribute: .trailing, multiplier: 1, constant: 0)
        secondItem.addConstraints([topConstraint, bottomConstraint, leadingConstraint, trailingConstraint])
    }
}
