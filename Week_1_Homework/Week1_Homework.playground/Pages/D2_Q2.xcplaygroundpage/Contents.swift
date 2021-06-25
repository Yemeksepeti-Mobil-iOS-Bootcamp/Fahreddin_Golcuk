/**
 Week 1 __ Day 2 __  Project Euler - Q2
 */

func evenValuesFibonacci() -> Int{
    var fibonacciArray: [Int] = [1,2]
    var number1 = 1, number2 = 2
    
    while number2 + number1 <= 4_000_000 {
        
        let nextValue = number2 + number1
        
        fibonacciArray.append(nextValue)
        number1 = number2
        number2 = nextValue
    }
    return fibonacciArray.filter{ number in return number % 2 == 0 }.reduce(0, +)
}

print(evenValuesFibonacci())

