//
//  UIViewController+Extension.swift
//  Steamgames
//
//  Created by Rodomil on 29.05.2023.
//

import UIKit

extension UIViewController {
    
    func keyboardWillShow(notification: NSNotification) -> CGFloat {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            return keyboardSize.height
        }
        return 0
    }
    
    func keyboardWillHide(constraint:NSLayoutConstraint, notification: NSNotification, constraintConstant: CGFloat = 0) {
        constraint.constant = constraintConstant
    }

    func getKeyBoardHeight(notification: NSNotification) -> CGFloat? {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
        else { return nil }
        return keyboardSize.height
    }
}

//extension UIViewController {
//
//    func getViewController(storyboardId: String, viewControllerId: String ) -> UIViewController {
//        let storyboard = UIStoryboard(name: storyboardId, bundle: nil)
//        return storyboard.instantiateViewController(identifier: viewControllerId)
//    }
//}


