//  Copyright (c) 2023 Feng Yang
//
//  I am making my contributions/submissions to this project solely in my
//  personal capacity and am not conveying any rights to any intellectual
//  property of any third parties.

import XCTest
@testable import Tween

class DelayActionTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    func testDelayActionReportsCorrectDuration() {

        let duration = 5.0
        let action = DelayAction(duration: duration)
        XCTAssertEqual(action.duration, duration, accuracy: 0.001)
    }

    // MARK: - Active / Inactive closures

    func testDelayActionOnBecomeActiveClosureIsCalled() {

        var numCalls = 0
        let action = DelayAction(duration: 1.0)
        action.onBecomeActive = {
            numCalls += 1
        }
        action.willBecomeActive()

        XCTAssertEqual(numCalls, 1)
    }

    func testDelayActionOnBecomeInactiveClosureIsCalled() {

        var numCalls = 0
        let action = DelayAction(duration: 1.0)
        action.onBecomeInactive = {
            numCalls += 1
        }
        action.simulateFullLifeCycle()

        XCTAssertEqual(numCalls, 1)
    }

}
