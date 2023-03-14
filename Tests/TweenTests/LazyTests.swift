//  Copyright (c) 2023 Feng Yang
//
//  I am making my contributions/submissions to this project solely in my
//  personal capacity and am not conveying any rights to any intellectual
//  property of any third parties.

import XCTest
@testable import Tween

class LazyTests: XCTestCase {

    func testLazyType() {

        var numberOfCalculations = 0

        let lazyInt = Lazy<Int> { () -> Int in
            numberOfCalculations += 1
            return 5
        }

        // Unused
        XCTAssertEqual(numberOfCalculations, 0)

        // Caclulate initial value
        XCTAssertEqual(lazyInt.value, 5)
        XCTAssertEqual(numberOfCalculations, 1)

        // Access cached value
        XCTAssertEqual(lazyInt.value, 5)
        XCTAssertEqual(numberOfCalculations, 1)
    }
}
