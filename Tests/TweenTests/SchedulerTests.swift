//  Copyright (c) 2023 Feng Yang
//
//  I am making my contributions/submissions to this project solely in my
//  personal capacity and am not conveying any rights to any intellectual
//  property of any third parties.

import XCTest
@testable import Tween

class SchedulerTests: XCTestCase {

    var scheduler: ActionScheduler!

    override func setUp() {
        super.setUp()
        scheduler = ActionScheduler()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testSchedulerReturnsCorrectNumberOfAnimations() {

        func addAnimation() {
            let action = InterpolationAction(from: 0.0, to: 1.0, duration: 1.0, easing: .linear, update: { _ in })
            let animation = Animation(action: action)
            scheduler.add(animation: animation)
        }

        XCTAssertEqual(scheduler.numRunningAnimations, 0)
        addAnimation()
        XCTAssertEqual(scheduler.numRunningAnimations, 1)
        addAnimation()
        XCTAssertEqual(scheduler.numRunningAnimations, 2)
        addAnimation()
        XCTAssertEqual(scheduler.numRunningAnimations, 3)
    }

    func testAnimationIsRemovedOnCompletion() {

        let duration = 0.1

        let action = InterpolationAction(from: 0.0, to: 1.0, duration: duration, easing: .linear) { _ in
        }
        let animation = Animation(action: action)
        scheduler.add(animation: animation)

        scheduler.progressTime(duration: duration + 0.1)
        XCTAssertEqual(scheduler.numRunningAnimations, 0)
    }
}
