//
//  Appearance.swift
//  Steamgames
//
//  Created by Rodomil on 29.05.2023.
//


import UIKit

/// Протокол для основных числовых констант для верстки содержащий цвета, альфы и прочее
public protocol Appearance {}

/// Содержит основные базовые числовые константы
extension Appearance {
    /// Нулевой значение
    public var zero: Int { 0 }
    
    public var heightBaseButton: Double { 54 }
    public var baseRadiusButton: Double { 16 }
    
    public var fontSize5: Double { 5 }
    public var fontSize14: Double { 14 }
    public var fontSize12: Double { 12 }
    public var fontSize16: Double { 16 }
    public var fontSize18: Double { 18 }
    public var fontSize24: Double { 24 }
    public var fontSize28: Double { 28 }
    
    //MARK: -Intro
    var introImageHeight: Double { 304 }
    var introTitleHeight: Double { 42 }
    var introImageStreenHeight: Double { 10 }
    var introImageStreenWidth: Double { 74 }
    
}

/// Обертка для Appearance совместимых типов
public struct AppearanceWrapper<Base>: Appearance {
    private let base: Base
    init(_ base: Base) {
        self.base = base
    }
}

/// Протокол описывающий которому должны конформить совместимы с Appearance типами
public protocol AppearanceCompatible: AnyObject {}

extension AppearanceCompatible {
    /// Предоставляет namespace обертку для Appearance совместимых типов.
    public var appearance: AppearanceWrapper<Self> { AppearanceWrapper(self) }
}
