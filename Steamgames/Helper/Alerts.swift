//
//  CircleView.swift
//  Tesla-dev
//
//  Created by Rodomil Rod on 21.07.2021.
//


import UIKit

class Alerts {
    
    static func activeView() -> UIViewController {
        let keyWindow = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        
        var topController = keyWindow?.rootViewController!
        while let presentedViewController = topController?.presentedViewController {
            topController = presentedViewController
        }
        return topController!
    }
    
    static func all(title: String, message: String, style: UIAlertController.Style) -> UIAlertController {
        let title = title
        let message = message
        let alert = UIAlertController(title: title, message: message, preferredStyle: style)
        let ok = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(ok)
        return alert

    }
    
    static func noConnectServer() {
        DispatchQueue.main.async {
            Alerts.activeView().present(Alerts.all(title: "Внимание", message: "Ощибка загрузки данных.", style: .alert), animated: true, completion: nil)
        }
    }
    
    static func noData() {
        DispatchQueue.main.async {
            Alerts.activeView().present(Alerts.all(title: "Внимание", message: "Здесь еще ничего нет.", style: .alert), animated: true, completion: nil)
        }
    }
    
        
}
