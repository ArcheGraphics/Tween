//  Copyright (c) 2023 Feng Yang
//
//  I am making my contributions/submissions to this project solely in my
//  personal capacity and am not conveying any rights to any intellectual
//  property of any third parties.

import Foundation

/** Can be used to add a delay to a sequence */
public class DelayAction: FiniteTimeAction {

    // MARK: - Public

    /**
     Create with duration
     - Parameter duration: The duration of the deley
     */
    public init(duration: Double) {
        self.duration = duration
    }

    // MARK: - Properties

    public let duration: Double
    public var reverse = false

    public var onBecomeActive: () -> () = {
    }
    public var onBecomeInactive: () -> () = {
    }

    // MARK: - Methods

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
    }
}
