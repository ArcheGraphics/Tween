//  Copyright (c) 2023 Feng Yang
//
//  I am making my contributions/submissions to this project solely in my
//  personal capacity and am not conveying any rights to any intellectual
//  property of any third parties.

import Foundation

// MARK: - Shedulable Action

/** Protocol for any action that can be added to an ActionScheduler instance */
public protocol SchedulableAction: AnyObject {
    /** Called when the action becomes active */
    var onBecomeActive: () -> () { get set }

    /** Called when the action becomes inactive */
    var onBecomeInactive: () -> () { get set }

    func willBecomeActive()
    func didBecomeInactive()

    func willBegin()
    func didFinish()
}

// MARK: - Finite Time Action

/** Protocol for Actions that have a finite duration */
public protocol FiniteTimeAction: SchedulableAction {
    var duration: Double { get }
    var reverse: Bool { get set }
    func update(t: CFTimeInterval)
}

// MARK: - Trigger Action

/** Protocol for actions that trigger an event and have no duration */
public protocol TriggerAction: FiniteTimeAction {
    func trigger()
}

extension TriggerAction {
    var duration: Double {
        0
    }
}

// MARK: - Infinite Time Action

/** Protocol for actions that run indefinitely */
public protocol InfiniteTimeAction: SchedulableAction {
    func update(elapsedTime: CFTimeInterval)
}
