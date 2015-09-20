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

    var keyboardShowing = false
    var keyboardHeight: CGFloat = 0.0
    var animationDuration: Double = 0.5
    var animationCurve: UInt = 0

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
        scrollViewInsets.top = scrollViewBounds.size.height
        scrollViewInsets.top -= contentViewBounds.size.height

        // http://stackoverflow.com/questions/18837166/how-to-mimic-keyboard-animation-on-ios-7-to-add-done-button-to-numeric-keyboar/19235995#19235995
        if(keyboardShowing) {
            scrollViewInsets.top -= keyboardHeight
            UIView.animateWithDuration(animationDuration, delay: animationDuration, options: UIViewAnimationOptions(rawValue: animationCurve), animations: { () -> Void in

                }, completion: { (completed) -> Void in

            })
            UIView.animateWithDuration(animationDuration) {
                self.scrollView.contentInset = scrollViewInsets
            }
        } else {
            self.scrollView.contentInset = scrollViewInsets
        }

    }

    // MARK - UITextFieldDelegate
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    func textFieldDidBeginEditing(textField: UITextField) {
        activeTextField = textField
    }

    func textFieldDidEndEditing(textField: UITextField) {
        activeTextField = nil
    }

    // MARK - Handle keyboard
    // https://developer.apple.com/library/ios/documentation/StringsTextFonts/Conceptual/TextAndWebiPhoneOS/KeyboardManagement/KeyboardManagement.html#//apple_ref/doc/uid/TP40009542-CH5-SW7
    // We can't use the code directly because we are messing with viewDidLayoutSubviews to position the forms at the bottom of the screen
    // So, unlike the link above, we do the animation in the

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
            // Grab the keyboard height (may vary depending on which keyboard is selected)
            if let keyboardSize = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.CGRectValue(){
                keyboardShowing = true
                keyboardHeight = keyboardSize.height
            }

            // Grab the animation style to match the duration and rate
            if let duration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as? Double {
                animationDuration = duration
            }
            if let curve = userInfo[UIKeyboardAnimationCurveUserInfoKey] as? UInt {
                animationCurve = curve
            }
        }
    }

    func keyboardWillBeHidden(notification: NSNotification) {
        keyboardShowing = false
        keyboardHeight = 0.0
    }

}

