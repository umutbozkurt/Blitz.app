//
//  MenuButton.swift
//  Blitz
//
//  Created by Umut Bozkurt on 04/01/16.
//  Copyright © 2016 Umut Bozkurt. All rights reserved.
//

import UIKit
import pop

protocol MenuButtonDataSource
{
    func numberOfButtons(menuButton: MenuButton) -> Int
    func itemForIndex(index: Int) -> MenuItem
}

protocol MenuButtonDelegate
{
    func menuButton(menuButton: MenuButton, didSelectItemAtIndex: Int)
}

class MenuButton: LBHamburgerButton
{
    var delegate: MenuButtonDelegate?
    var dataSource: MenuButtonDataSource?
    var items: [MenuItem] = []
    
    override func switchState()
    {
        for var index = 0; index < getItems().count; ++index
        {
            let item = getItems()[index]
            item.parent = self
            
            let initialFrame = self.frame
            let targetFrame = CGRectMake(
                self.frame.origin.x,
                self.frame.origin.y - CGFloat(index + 1) * (MenuItem.height + MenuItem.margin),
                MenuItem.width,
                MenuItem.height
            )
            
            let animation = POPSpringAnimation(propertyNamed: kPOPViewFrame)

            if hamburgerState == LBHamburgerButtonState.Hamburger
            {
                animation.fromValue = NSValue(CGRect: initialFrame)
                animation.toValue = NSValue(CGRect: targetFrame)
                self.superview?.insertSubview(item, belowSubview: self)
            }
            else
            {
                animation.fromValue = NSValue(CGRect: targetFrame)
                animation.toValue = NSValue(CGRect: initialFrame)
                animation.completionBlock = {(anim, completed) in
                    item.removeFromSuperview()
                }
            }
            
            animation.springSpeed = CGFloat(30)
            animation.springBounciness = CGFloat(15)
            animation.dynamicsFriction = CGFloat(30)
            
            item.pop_removeAllAnimations()
            item.pop_addAnimation(animation, forKey: "spring")
        }
        super.switchState()
    }
    
    func getItems() -> Array<MenuItem>
    {
        if items.isEmpty
        {
            let count = dataSource?.numberOfButtons(self) ?? 0
            
            for index in 1...count
            {
                items.append((dataSource?.itemForIndex(index))!)
            }
        }
        
        return items
    }
    
    func didTapMenuItem(menuItem: MenuItem)
    {
        let items = getItems()
        
        for index in 0...items.count
        {
            if items[index] == menuItem
            {
                delegate?.menuButton(self, didSelectItemAtIndex: index)
                break
            }
        }
    }
}
