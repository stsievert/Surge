//
//  InitializeTests.swift
//  Surge
//
//  Created by scott on 2/1/17.
//  Copyright © 2017 Mattt Thompson. All rights reserved.
//

import Foundation
import XCTest
import Surge

class InitializeTests: XCTestCase {
    func testZeros(){
        let n = 3
        var x:[Double] = zeros(n)
        assert(x == [0, 0, 0])
        
        x = [1, 3, 4, 5]
        let y = zeros_like(x)
        assert(y == [0, 0, 0, 0])
    }
    func testOne(){
        var x:[Double] = ones(4)
        assert(x == [1, 1, 1, 1])
        
        x = [1, 2, 3, 4]
        assert(ones_like(x) == [1, 1, 1, 1])
    }
    func testArange(){
        var x = arange(4)
        assert(x == [0, 1, 2, 3])
        
        x = arange(4, inclusive:true)
        assert(x == [0, 1, 2, 3, 4])
    }
    func testRange(){
        let x = range(0, max:1, step:0.5)
        assert(x == [0, 0.5, 1])
    }
    func testRand(){
        seed(42)
        let x1 = rand(10)
        seed(42)
        let x2 = rand(10)
        assert(x1 == x2)
        
        let x3 = rand(10)
        assert(x3 != x2)
    }
    
    func testLinspace(){
        // tested against numpy
        let x = linspace(0, max:1, num: 6)
        assert(max(x) == 1)
        assert(min(x) == 0)
        assert(x.count == 6)
    }
}
