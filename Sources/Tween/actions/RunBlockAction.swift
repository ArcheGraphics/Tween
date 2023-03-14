//  Copyright (c) 2023 Feng Yang
//
//  I am making my contributions/submissions to this project solely in my
//  personal capacity and am not conveying any rights to any intellectual
//  property of any third parties.

import Foundation

/** Runs a block. Can be used to add callbacks in sequences */
public class RunBlockAction: TriggerAction {

    // MARK: - Public

    public var onBecomeActive: () -> () = {
    }
    public var onBecomeInactive: () -> () = {
    }

    /**
     Create with a callback closure
     - Parameter handler: The closure to call
     */
    public init(handler: @escaping () -> ()) {
        self.handler = handler
    }

    // MARK: - Private

    let handler: () -> ()
    public let duration = 0.0
    public var reverse: Bool = false

    public func trigger() {
        handler()
    }

    public func willBecomeActive() {
        onBecomeActive()
    }

    public func didBecomeInactive() {
        onBecomeInactive()
    }

    public func willBegin() {
    }

    public func didFinish() {
    }

    public func update(t: CFTimeInterval) {
        // Do nothing
    }
}
