//  Copyright (c) 2023 Feng Yang
//
//  I am making my contributions/submissions to this project solely in my
//  personal capacity and am not conveying any rights to any intellectual
//  property of any third parties.

import XCTest
@testable import Tween

extension FloatingPoint {
    var degreesToRadians: Self {
        return self * .pi / 180
    }
    var radiansToDegrees: Self {
        return self * 180 / .pi
    }
}

class ArcActionTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }

    func testArcActionProducesExpectedStartAndEndValues() {

        var value = CGPoint.zero

        let center = CGPoint(x: 100, y: 100)
        let radius = 50.0

        // Create and start the action
        let action = ArcAction(center: center,
                radius: radius,
                startDegrees: 0.0,
                endDegrees: 90.0,
                duration: 5.0,
                update: { value = $0 })

        action.willBecomeActive()
        action.willBegin()

        // Test start value
        action.update(t: 0.0)
        let expectedStartValue = CGPoint(x: center.x,
                y: center.y - CGFloat(radius))

        AssertCGPointsAreEqualWithAccuracy(value, expectedStartValue, accuracy: 0.001)

        // Test end value
        action.update(t: 1.0)
        let expectedEndValue = CGPoint(x: center.x + CGFloat(radius),
                y: center.y)

        AssertCGPointsAreEqualWithAccuracy(value, expectedEndValue, accuracy: 0.001)
    }

    func testArcActionLifeCycleEventsUpdateValue() {

        var value = CGPoint.zero

        let center = CGPoint(x: 100, y: 100)
        let radius = 50.0

        let action = ArcAction(center: center,
                radius: radius,
                startDegrees: 0.0,
                endDegrees: 90.0,
                duration: 5.0,
                update: { value = $0 })

        action.simulateFullLifeCycle()

        let expectedValue = CGPoint(x: center.x + CGFloat(radius),
                y: center.y)

        AssertCGPointsAreEqualWithAccuracy(value, expectedValue, accuracy: 0.001)
    }

    // MARK: - Active / Inactive closures

    func testArcActionOnBecomeActiveClosureIsCalled() {

        var numCalls = 0
        let action = ArcAction(center: CGPoint.zero, radius: 5, startDegrees: 0, endDegrees: 0, duration: 1, update: { _ in })
        action.onBecomeActive = {
            numCalls += 1
        }
        action.willBecomeActive()

        XCTAssertEqual(numCalls, 1)
    }

    func testArcActionOnBecomeInactiveClosureIsCalled() {

        var numCalls = 0
        let action = ArcAction(center: CGPoint.zero, radius: 5, startDegrees: 0, endDegrees: 0, duration: 1, update: { _ in })
        action.onBecomeInactive = {
            numCalls += 1
        }
        action.simulateFullLifeCycle()

        XCTAssertEqual(numCalls, 1)
    }

}
