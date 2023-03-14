//  Copyright (c) 2023 Feng Yang
//
//  I am making my contributions/submissions to this project solely in my
//  personal capacity and am not conveying any rights to any intellectual
//  property of any third parties.

import Foundation

func vector2DDistance(v1: (x: Double, y: Double), v2: (x: Double, y: Double)) -> Double {

    let xDiff = v2.x - v1.x
    let yDiff = v2.y - v1.y

    return sqrt((xDiff * xDiff) + (yDiff * yDiff))
}

func max<T: Comparable>(_ values: T...) -> T {

    var maxValue = values.first!

    values.dropFirst().forEach {
        maxValue = max(maxValue, $0)
    }

    return maxValue
}

extension Comparable {

    func constrained(min: Self) -> Self {

        if self < min {
            return min
        }
        return self
    }

    func constrained(max: Self) -> Self {

        if self > max {
            return max
        }
        return self
    }

    func constrained(min: Self, max: Self) -> Self {

        if self < min {
            return min
        }
        if self > max {
            return max
        }
        return self
    }
}

extension Double {

    var fract: Double {
        return self - Double(Int(self))
    }

    var orZeroIfNanOrInfinite: Double {
        if self.isNaN || self.isInfinite {
            return 0
        } else {
            return self
        }
    }
}
