//  Copyright (c) 2023 Feng Yang
//
//  I am making my contributions/submissions to this project solely in my
//  personal capacity and am not conveying any rights to any intellectual
//  property of any third parties.

import XCTest
@testable import Tween

class RunBlockActionTests: XCTestCase {

    // MARK: - Test Trigger Closure

    func testClosureIsInvoked() {

        var wasInvoked = false

        let action = RunBlockAction {
            wasInvoked = true
        }

        action.trigger()
        action.willBecomeActive()

        XCTAssertTrue(wasInvoked)
    }

    func testClosureCanBeInvokedMultipleTimes() {

        let numTimes = 10

        var numTimesInvoked = 0

        let action = RunBlockAction {
            numTimesInvoked += 1
        }

        (0..<numTimes).forEach { _ in
            action.trigger()
        }

        XCTAssertEqual(numTimesInvoked, numTimes)
    }

    // MARK: - Active / Inactive closures

    func testRepeatActionOnBecomeActiveClosureIsCalled() {

        var numCalls = 0
        let runBlock = FiniteTimeActionMock(duration: 1.0)
        runBlock.onBecomeActive = {
            numCalls += 1
        }
        runBlock.willBecomeActive()

        XCTAssertEqual(numCalls, 1)
    }

    func testRepeatActionOnBecomeInactiveClosureIsCalled() {

        var numCalls = 0
        let runBlock = FiniteTimeActionMock(duration: 1.0)
        runBlock.onBecomeInactive = {
            numCalls += 1
        }
        runBlock.simulateFullLifeCycle()

        XCTAssertEqual(numCalls, 1)
    }


}
