//  Copyright (c) 2023 Feng Yang
//
//  I am making my contributions/submissions to this project solely in my
//  personal capacity and am not conveying any rights to any intellectual
//  property of any third parties.

import Foundation

/** Ticker is used to simulate the progression of time for tests */
class Ticker {

    var stepTime = 1.0 / 60.0
    let duration: Double
    let callback: (Double) -> ()

    init(duration: Double, callback: @escaping (_ dt: Double) -> ()) {

        self.duration = duration
        self.callback = callback
    }

    func run() {

        var remainingTime = duration

        while remainingTime - stepTime > 0 {
            callback(stepTime)
            remainingTime -= stepTime
        }

        callback(remainingTime)
    }
}
