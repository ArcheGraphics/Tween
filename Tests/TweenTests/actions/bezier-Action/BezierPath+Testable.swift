//  Copyright (c) 2023 Feng Yang
//
//  I am making my contributions/submissions to this project solely in my
//  personal capacity and am not conveying any rights to any intellectual
//  property of any third parties.

#if canImport(UIKit)

import Foundation
import UIKit
@testable import Tween

func makeBasicTestPath() -> BezierPath<CGPoint> {

    let startPoint = CGPoint(x: 50, y: 50)
    let endPoint = CGPoint(x: 100, y: 100)

    let path = BezierPath(start: startPoint,
            curves: [.lineToPoint(endPoint)])
    return path
}

#endif
