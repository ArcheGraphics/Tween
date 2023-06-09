//  Copyright (c) 2023 Feng Yang
//
//  I am making my contributions/submissions to this project solely in my
//  personal capacity and am not conveying any rights to any intellectual
//  property of any third parties.

import Foundation
import Tween

extension SchedulableAction {
    func simulateFullLifeCycle() {
        self.willBecomeActive()
        self.willBegin()
        self.didFinish()
        self.didBecomeInactive()
    }
}


