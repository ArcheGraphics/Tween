//  Copyright (c) 2023 Feng Yang
//
//  I am making my contributions/submissions to this project solely in my
//  personal capacity and am not conveying any rights to any intellectual
//  property of any third parties.

#if canImport(UIKit)

import Foundation
import UIKit

extension UIColor: Tweenable {
    public func lerp(t: Double, end: UIColor) -> Self {

        var thisR: CGFloat = 0
        var thisG: CGFloat = 0
        var thisB: CGFloat = 0
        var thisA: CGFloat = 0

        getRed(&thisR, green: &thisG, blue: &thisB, alpha: &thisA)

        var endR: CGFloat = 0
        var endG: CGFloat = 0
        var endB: CGFloat = 0
        var endA: CGFloat = 0

        end.getRed(&endR, green: &endG, blue: &endB, alpha: &endA)

        return type(of: self).init(red: thisR + (endR - thisR) * CGFloat(t),
                green: thisG + (endG - thisG) * CGFloat(t),
                blue: thisB + (endB - thisB) * CGFloat(t),
                alpha: thisA + (endA - thisA) * CGFloat(t))
    }

    public func distanceTo(other: UIColor) -> Double {
        fatalError("Not implemented")
    }
}

#endif
