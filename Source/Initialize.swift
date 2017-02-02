//
//  Initialize.swift
//  Surge
//
//  Created by Scott Sievert on 2/1/17.
//  Copyright © 2017 Mattt Thompson. All rights reserved.
//

import Accelerate

public func zeros(_ N: Int) -> [Double] {
    return [Double](repeating: 0.0, count: N)
}

public func zeros_like(_ x: [Double]) -> [Double] {
    // make an array like the other array
    return zeros(x.count)
}

public func ones_like(_ x: [Double]) -> [Double] {
    // make an array like the other array
    return zeros_like(x) + 1
}
public func ones(_ N: Int) -> [Double]{
    // N ones
    return zeros(N) + 1
}

public func arange(_ max: Int, inclusive:Bool = false) -> [Double]{
    // 0..<max
    return arange(0, max: Double(max), inclusive:inclusive)
}

public func range(_ min:Double, max:Double, step:Double) -> [Double]{
    // min, min+step, min+2*step..., max-step, max
    return linspace(min, max: max, num:1+Int(((max-min)/step)))
}

public func arange(_ min: Double, max: Double, inclusive: Bool = false) -> [Double]{
    // min...max
    var pad = 0
    if inclusive {pad = 1}
    let N = Int(max) - Int(min) + pad
    var x = zeros(N)
    var o = CDouble(min)
    var l = CDouble(1)
    vDSP_vrampD(&o, &l, &x, 1, UInt(N))
    return x
}

var _surge_seed:__CLPK_integer = 42

public func seed(_ n:Int){
    _surge_seed = __CLPK_integer(n)
}

public func rand(_ N: Int) -> [Double]{
    var x = zeros(N)
    var i:__CLPK_integer = 1
    var seed:Array<__CLPK_integer> = [Int32(_surge_seed), 2, 3, 5]
    var nn:__CLPK_integer  = __CLPK_integer(N)
    
    dlarnv_(&i, &seed, &nn, &x)
    
    _surge_seed = __CLPK_integer(seed[0])
    return x
}


public func linspace(_ min: Double, max: Double, num: Int=50) -> [Double] {
    var x:[Double] = zeros(num)
    var min  = CDouble(min)
    var step = CDouble((max-min)/(CDouble(num-1)))
    vDSP_vrampD(&min, &step, &x, 1, vDSP_Length(x.count))
    return x
}
