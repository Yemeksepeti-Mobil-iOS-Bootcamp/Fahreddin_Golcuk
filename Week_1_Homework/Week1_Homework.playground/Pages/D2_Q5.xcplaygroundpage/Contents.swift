/**
 Week 1 __ Day 2 __  Project Euler - Q5
 */

func smallestPositive() -> Int{
    var number: Int = 1
    
    while true {
        
        var isDivided: Bool = false
        
        for division in 1...20 {
            if number % division != 0 {
                isDivided = true
            }
        }
        
        if !isDivided {
            return number
        }
        
        number += 1
    }
}

print(smallestPositive())
