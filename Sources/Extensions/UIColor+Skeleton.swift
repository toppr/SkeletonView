//
//  UIColor+Skeleton.swift
//  SkeletonView-iOS
//
//  Created by Juanpe Catalán on 03/11/2017.
//  Copyright © 2017 SkeletonView. All rights reserved.
//

import UIKit

extension UIColor {
    
    //    convenience init(_ hex: UInt) {
    //        self.init(
    //            red: CGFloat((hex & 0xFF0000) >> 16) / 255.0,
    //            green: CGFloat((hex & 0x00FF00) >> 8) / 255.0,
    //            blue: CGFloat(hex & 0x0000FF) / 255.0,
    //            alpha: CGFloat(1.0)
    //        )
    //    }
    
    convenience init(_ hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
    
    func isLight() -> Bool {
        // algorithm from: http://www.w3.org/WAI/ER/WD-AERT/#color-contrast
        guard let components = cgColor.components,
            components.count >= 3 else { return false }
        let brightness = ((components[0] * 299) + (components[1] * 587) + (components[2] * 114)) / 1000
        return !(brightness < 0.5)
    }
    
    public var complementaryColor: UIColor {
        return isLight() ? darker : lighter
    }
    
    public var lighter: UIColor {
        return adjust(by: 1.35)
    }
    
    public var darker: UIColor {
        return adjust(by: 0.94)
    }
    
    func adjust(by percent: CGFloat) -> UIColor {
        var h: CGFloat = 0, s: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        getHue(&h, saturation: &s, brightness: &b, alpha: &a)
        return UIColor(hue: h, saturation: s, brightness: b * percent, alpha: a)
    }
    
    func makeGradient() -> [UIColor] {
        return [self, self.complementaryColor, self]
    }
}

public extension UIColor {
    static var greenSea     = UIColor("16a085")
    static var turquoise    = UIColor("1abc9c")
    static var emerald      = UIColor("2ecc71")
    static var peterRiver   = UIColor("3498db")
    static var amethyst     = UIColor("9b59b6")
    static var wetAsphalt   = UIColor("34495e")
    static var nephritis    = UIColor("27ae60")
    static var belizeHole   = UIColor("2980b9")
    static var wisteria     = UIColor("8e44ad")
    static var midnightBlue = UIColor("2c3e50")
    static var sunFlower    = UIColor("f1c40f")
    static var carrot       = UIColor("e67e22")
    static var alizarin     = UIColor("e74c3c")
    static var clouds       = UIColor("ecf0f1")
    static var concrete     = UIColor("95a5a6")
    static var flatOrange   = UIColor("f39c12")
    static var pumpkin      = UIColor("d35400")
    static var pomegranate  = UIColor("c0392b")
    static var silver       = UIColor("bdc3c7")
    static var asbestos     = UIColor("7f8c8d")
}
