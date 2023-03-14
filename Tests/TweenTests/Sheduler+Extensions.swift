//  Copyright (c) 2023 Feng Yang
//
//  I am making my contributions/submissions to this project solely in my
//  personal capacity and am not conveying any rights to any intellectual
//  property of any third parties.

import Foundation
@testable import Tween

extension ActionScheduler {
    func progressTime(duration: Double, stepSize: Double = 1.0 / 60.0) {
        Ticker(duration: duration) {
            self.step(dt: $0)
        }
                .run()
    }
}
