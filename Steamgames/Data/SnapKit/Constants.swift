//
//  Constants.swift
//  Steamgames
//
//  Created by Rodomil on 29.05.2023.
//

import Foundation
import UIKit

/// Протокол где находятся числовые и текстовые константы
public protocol Constants {}

/// Содержит основные базовые числовые константы
extension Constants {
    
    var locationDatePicker: String { "ru_RU" }
    
//    public func customSizeFont(sizeCus: Double) -> UIFont? {
//        return UIFont(name: nameFont, size: sizeCus)
//    }
//    
//    public func customSizeBoldFont(sizeCus: Double) -> UIFont? {
//        return UIFont(name: nameBoldFont, size: sizeCus)
//    }
//    
//    public func customSizeRegularFont(sizeCus: Double) -> UIFont? {
//        return UIFont(name: nameRegularFont, size: sizeCus)
//    }
//    
//    public func customSizeMediumFont(sizeCus: Double) -> UIFont? {
//        return UIFont(name: nameMediumFont, size: sizeCus)
//    }
}

/// Обертка для Appearance совместимых типов
public struct ConstantsWrapper<Base>: Constants {
    private let base: Base
    init(_ base: Base) {
        self.base = base
    }
}

/// Протокол описывающий которому должны конформить совместимы с Appearance типами
public protocol ConstantsCompatible: AnyObject {}

extension ConstantsCompatible {
    /// Предоставляет namespace обертку для Appearance совместимых типов.
    public var constants: ConstantsWrapper<Self> { ConstantsWrapper(self) }
}
