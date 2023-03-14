//  Copyright (c) 2023 Feng Yang
//
//  I am making my contributions/submissions to this project solely in my
//  personal capacity and am not conveying any rights to any intellectual
//  property of any third parties.

import XCTest
import Tween

class ActionScrubberTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }

    // MARK: - Scrubbing

    func testActionScrubberScrubsInnerActionWhenUpdateT() {

        var value = 0.0

        let action = InterpolationAction(from: 1.0,
                to: 3.0,
                duration: 0.1,
                easing: .linear) {
            value = $0
        }

        let scrubber = ActionScrubber(action: action)
        scrubber.update(t: 0.5)

        XCTAssertEqual(value, 2.0, accuracy: 0.0001)
    }

    func testActionScrubberScrubsInnerActionWhenUpdateElapsedTime() {

        var value = 0.0

        let action = InterpolationAction(from: 1.0,
                to: 3.0,
                duration: 0.1,
                easing: .linear) {
            value = $0
        }

        let scrubber = ActionScrubber(action: action)
        scrubber.update(elapsedTime: action.duration / 2)

        XCTAssertEqual(value, 2.0, accuracy: 0.0001)
    }

    // MARK: - Clamping

    func testCanScrubPastBeginningWithClampingDisabled() {

        var value = 0.0

        let action = InterpolationAction(from: 0.0, to: 1.0, duration: 1.0, easing: .linear) {
            value = $0
        }

        let scrubber = ActionScrubber(action: action)
        scrubber.clampTValuesBelowZero = false
        scrubber.update(t: -0.4)

        XCTAssertLessThan(value, -0.01)
    }

    func testCanScrubPastEndWithClampingDisabled() {

        var value = 0.0

        let action = InterpolationAction(from: 0.0, to: 1.0, duration: 1.0, easing: .linear) {
            value = $0
        }

        let scrubber = ActionScrubber(action: action)
        scrubber.clampTValuesAboveOne = false
        scrubber.update(t: 3)

        XCTAssertGreaterThan(value, 1.01)
    }

    func testCannotScrubPastBeginningWithClampingEnabled() {

        var value = 0.0

        let action = InterpolationAction(from: 0.0, to: 1.0, duration: 1.0, easing: .linear) {
            value = $0
        }

        let scrubber = ActionScrubber(action: action)
        scrubber.clampTValuesBelowZero = true
        scrubber.update(t: -0.4)

        XCTAssertEqual(value, 0.0, accuracy: 0.001)
    }

    func testCannotScrubPastEndWithClampingEnabled() {

        var value = 0.0

        let action = InterpolationAction(from: 0.0, to: 1.0, duration: 1.0, easing: .linear) {
            value = $0
        }

        let scrubber = ActionScrubber(action: action)
        scrubber.clampTValuesAboveOne = true
        scrubber.update(t: 3)

        XCTAssertEqual(value, 1.0, accuracy: 0.001)
    }


}
