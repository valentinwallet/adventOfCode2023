//
//  Math.swift
//
//
//  Created by Valentin Wallet on 09/12/2023.
//

struct Math {
    static func GCD(number1: Int, number2: Int) -> Int {
        var x = 0
        var y: Int = max(number1, number2)
        var z: Int = min(number1, number2)
        
        while z != 0 {
            x = y
            y = z
            z = x % y
        }
        
        return y
    }
    
    static func LCM(number1: Int, number2: Int) -> Int {
        return (number1 * number2 / GCD(number1: number1, number2: number2))
    }
}
