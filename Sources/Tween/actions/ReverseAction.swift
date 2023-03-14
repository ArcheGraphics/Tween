//  Copyright (c) 2023 Feng Yang
//
//  I am making my contributions/submissions to this project solely in my
//  personal capacity and am not conveying any rights to any intellectual
//  property of any third parties.

import Foundation

/** Reverses the inner action */
public class ReverseAction: FiniteTimeAction {

    // MARK: - Public

    public var onBecomeActive: () -> () = {
    }
    public var onBecomeInactive: () -> () = {
    }

    /**
     Create with the action to reverse
     - Parameter action: The action to reverse
     */
    init(action: FiniteTimeAction) {
        self.action = action
        self.action.reverse = true
    }

    // MARK: - Private Properties
    var action: FiniteTimeAction

    // MARK: - Private Methods

    public var reverse: Bool = false {
        didSet {
            action.reverse = !reverse
        }
    }

    public var duration: Double {
        return action.duration
    }

    public func willBecomeActive() {
        action.willBecomeActive()
        onBecomeActive()
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

    public func update(t: CFTimeInterval) {
        action.update(t: 1 - t)
    }
}

public extension FiniteTimeAction {
    func reversed() -> ReverseAction {
        return ReverseAction(action: self)
    }
}
