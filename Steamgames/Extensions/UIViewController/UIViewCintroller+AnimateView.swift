//
//  UIViewCintroller+AnimateView.swift
//  Steamgames
//
//  Created by Rodomil on 29.05.2023.
//

import UIKit

// в метод подается alpha которая должны быть после анимации.
extension UIViewController {
    func animateView(view: UIView, duration: Double, alpha: CGFloat) {
        view.alpha = alpha == 0 ? 1 : 0
        if alpha == 1 { view.isHidden = false }
        UIView.animate(withDuration: duration, delay: 0, animations: {
            view.alpha = alpha
        }) { (isCompleted) in
            DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                if alpha == 0 { view.isHidden = true }
            }
        }
    }
}
