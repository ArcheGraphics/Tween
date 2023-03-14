//  Copyright (c) 2023 Feng Yang
//
//  I am making my contributions/submissions to this project solely in my
//  personal capacity and am not conveying any rights to any intellectual
//  property of any third parties.

import XCTest
@testable import Tween

class RepeatActionTests: XCTestCase {

    var scheduler: ActionScheduler!

    override func setUp() {
        super.setUp()

        scheduler = ActionScheduler(automaticallyAdvanceTime: false)
    }

    func testRepeatActionIsExpectedLength() {

        let numRepeats = 3

        let action = InterpolationAction(from: 0.0, to: 1.0, duration: 5.0, easing: .linear, update: { _ in })
        let repeatedAction = RepeatAction(action: action, times: numRepeats)

        XCTAssertEqual(action.duration * Double(numRepeats), repeatedAction.duration, accuracy: 0.001)
    }

    func testActionIsRunCorrectNumberOfTimes() {

        let action = FiniteTimeActionMock(duration: 0.1)
        let repeatedAction = action.repeated(3)

        let expectedEvents: [EventType] = [.willBecomeActive,
                                           .willBegin,
                                           .didFinish,
                                           .willBegin,
                                           .didFinish,
                                           .willBegin,
                                           .didFinish,
                                           .didBecomeInactive,
        ]

        let animation = Animation(action: repeatedAction)
        scheduler.add(animation: animation)
        scheduler.progressTime(duration: repeatedAction.duration + 0.1)

        AssertLifeCycleEventsAreAsExpected(recordedEvents: action.loggedEvents,
                expectedEvents: expectedEvents,
                filter: .onlyMatchingExpectedEventsTypes)
    }

    // MARK: - Inner Action Life

    func testInnerActionExpectedLifeCycleEventsAreCalled() {

        let action = FiniteTimeActionMock(duration: 5.0)
        let repeated = action.repeated(3)
        repeated.simulateFullLifeCycle()

        let expectedEvents: [EventType] = [.willBecomeActive,
                                           .willBegin,
                                           .didFinish,
                                           .willBegin,
                                           .didFinish,
                                           .willBegin,
                                           .didFinish,
                                           .didBecomeInactive]

        AssertLifeCycleEventsAreAsExpected(recordedEvents: action.loggedEvents,
                expectedEvents: expectedEvents,
                filter: .onlyMatchingExpectedEventsTypes)
    }

    func testInnerActionExpectedLifeCycleEventsAreCalledWhenReversed() {

        let action = FiniteTimeActionMock(duration: 5.0)
        let repeated = action.repeated(3)
        repeated.reverse = true
        repeated.simulateFullLifeCycle()

        let expectedEvents: [EventType] = [.setReversed(reversed: true),
                                           .willBecomeActive,
                                           .willBegin,
                                           .didFinish,
                                           .willBegin,
                                           .didFinish,
                                           .willBegin,
                                           .didFinish,
                                           .didBecomeInactive]

        AssertLifeCycleEventsAreAsExpected(recordedEvents: action.loggedEvents,
                expectedEvents: expectedEvents,
                filter: .onlyMatchingExpectedEventsTypes)
    }

    // MARK: - Active / Inactive closures

    func testRepeatActionOnBecomeActiveClosureIsCalled() {

        var numCalls = 0
        let inner = FiniteTimeActionMock(duration: 1.0)
        let repeated = inner.repeated(3)
        repeated.onBecomeActive = {
            numCalls += 1
        }
        repeated.willBecomeActive()

        XCTAssertEqual(numCalls, 1)
    }

    func testRepeatActionOnBecomeInactiveClosureIsCalled() {

        var numCalls = 0
        let inner = FiniteTimeActionMock(duration: 1.0)
        let repeated = inner.repeated(3)
        repeated.onBecomeInactive = {
            numCalls += 1
        }
        repeated.simulateFullLifeCycle()

        XCTAssertEqual(numCalls, 1)
    }
}
