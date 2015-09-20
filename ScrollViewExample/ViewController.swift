//
//  ViewController.swift
//  ScrollViewExample
//
//  Created by Nick Chen on 9/19/15.
//  Copyright © 2015 Nick Chen. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!

    var activeTextField: UITextField?

    override func viewWillAppear(animated: Bool) {
        super.viewDidLoad()
        registerForKeyboardNotifications()
    }

    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        NSNotificationCenter.defaultCenter().removeObserver(self);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK - Positioning

    override func viewDidLayoutSubviews() {
        // This deliberately moves the keyboard to the bottom of the screen
        let scrollViewBounds = scrollView.bounds
        let contentViewBounds = contentView.bounds

        var scrollViewInsets = UIEdgeInsetsZero
        scrollViewInsets.top = scrollViewBounds.size.height;
        scrollViewInsets.top -= contentViewBounds.size.height;

        scrollView.contentInset = scrollViewInsets
    }

    // MARK - UITextFieldDelegate
    
    func textFieldDidBeginEditing(textField: UITextField) {
        activeTextField = textField
    }

    func textFieldDidEndEditing(textField: UITextField) {
        activeTextField = nil
    }

    // MARK - Handle keyboard
    // https://developer.apple.com/library/ios/documentation/StringsTextFonts/Conceptual/TextAndWebiPhoneOS/KeyboardManagement/KeyboardManagement.html#//apple_ref/doc/uid/TP40009542-CH5-SW7

    func registerForKeyboardNotifications() {
        let notificationCenter = NSNotificationCenter.defaultCenter()
        notificationCenter.addObserver(self,
            selector: "keyboardWillBeShown:",
            name: UIKeyboardWillShowNotification,
            object: nil)
        notificationCenter.addObserver(self,
            selector: "keyboardWillBeHidden:",
            name: UIKeyboardWillHideNotification,
            object: nil)
    }

    func keyboardWillBeShown(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            if let keyboardSize = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.CGRectValue(){
            }
        }
    }

    func keyboardWillBeHidden(notification: NSNotification) {

    }

}

