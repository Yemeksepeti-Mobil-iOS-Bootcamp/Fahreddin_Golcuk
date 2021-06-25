/**
 Week 1 __ Day 2 __  Project Euler - Q3
 */

var primeFactoryNumber: Int = 600_851_475_143

func largestPrimeFactoryNumber(number: inout Int) -> Int {
    var result: Int = 0
    var division: Int = 2, maxFactory: Int = 0
    
    while number != 0 {
        
        if number % division != 0 {
            division += 1
        } else {
            maxFactory = number
            number = number / division
            
            if ( number == 1) {
                result = maxFactory
                break
            }
            
        }
    }
    return result
}

print(largestPrimeFactoryNumber(number: &primeFactoryNumber))
