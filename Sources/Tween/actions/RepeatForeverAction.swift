//  Copyright (c) 2023 Feng Yang
//
//  I am making my contributions/submissions to this project solely in my
//  personal capacity and am not conveying any rights to any intellectual
//  property of any third parties.

import Foundation

/** Repeats inner action forever */
public class RepeatForeverAction: InfiniteTimeAction {

    // MARK: - Public

    public var onBecomeActive: () -> () = {
    }
    public var onBecomeInactive: () -> () = {
    }

    /**
     Create with an action to repeat forever
     - Parameter action: The action to repeat
     */
    public init(action: FiniteTimeAction) {
        self.action = action;
    }

    // MARK: - Private Properties
    let action: FiniteTimeAction
    var lastRepeatNumber = 0

    // MARK: - Private Methods

    public func willBecomeActive() {
        onBecomeActive()
        action.willBecomeActive()
    }

    public func didBecomeInactive() {
        action.didBecomeInactive()
        onBecomeInactive()
    }

    public func willBegin() {
        action.willBegin()
    }

    public func didFinish() {
        action.didFinish()
    }

    public func update(elapsedTime: CFTimeInterval) {

        let repeatNumberDouble = (elapsedTime / action.duration).orZeroIfNanOrInfinite
        let repeatNumber = Int(repeatNumberDouble)

        (lastRepeatNumber..<repeatNumber).forEach { _ in
            self.action.didFinish()
            self.action.willBegin()
        }

        let actionT = repeatNumberDouble.fract
        action.update(t: actionT)

        lastRepeatNumber = repeatNumber
    }
}

public extension FiniteTimeAction {

    func repeatedForever() -> RepeatForeverAction {
        return RepeatForeverAction(action: self)
    }
}
