//
//  AddBlitzViewController.swift
//  Blitz
//
//  Created by Umut Bozkurt on 06/01/16.
//  Copyright © 2016 Umut Bozkurt. All rights reserved.
//

import UIKit
import pop

class AddBlitzViewController: BaseViewController
{
    override func viewDidLoad()
    {
        super.viewDidLoad()

        menuButton = MenuButton(type: MenuButtonType.BackButton)
        menuButton!.placeLowerRight(ofView: view)
        menuButton!.addTarget(self, action: "dismiss:", forControlEvents: .TouchUpInside)
        menuButton!.switchState()
        
        let cameraButton = CameraButton()
        cameraButton.placeUpperMiddle(ofView: view)
        
        let libraryButton = PhotoLibraryButton()
        libraryButton.placeLowerMiddle(ofView: view)
    }
    
    func dismiss(sender: AnyObject?)
    {
        transitionView = sender as? UIView
        self.navigationController?.popViewControllerAnimated(true)
    }
}
