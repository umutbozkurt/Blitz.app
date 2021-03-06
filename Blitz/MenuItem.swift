//
//  MenuItem.swift
//  Blitz
//
//  Created by Umut Bozkurt on 04/01/16.
//  Copyright © 2016 Umut Bozkurt. All rights reserved.
//

import UIKit

class MenuItem: UIButton
{
    static let width: CGFloat = 50
    static let height: CGFloat = 50
    static let margin: CGFloat = 10
    
    weak var parent: MenuButton?
    {
        didSet
        {
            self.addTarget(parent, action: "didTapMenuItem:", forControlEvents: UIControlEvents.TouchUpInside)
        }
    }
    
    init(image: UIImage, highlightedImage: UIImage)
    {
        super.init(frame: CGRectZero)
        self.backgroundColor = UIColor.blitzDarkBlueColor()
        self.setImage(image, forState: UIControlState.Normal)
        self.setImage(highlightedImage, forState: UIControlState.Highlighted)
    }
    
    override var frame: CGRect
    {
        didSet
        {
            self.layer.cornerRadius = frame.size.width / 2
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
