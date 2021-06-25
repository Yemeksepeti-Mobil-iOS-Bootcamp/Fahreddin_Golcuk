/**
Week 1 __ Day 2 __  Project Euler - Q1
 */

let maxNumber = 1000

func multiples3and5(max: Int) -> Int{
    var exist = Array<Int>()
    
    for number in 1...( max - 1 ) {
        
        if number % 3 == 0 || number % 5 == 0 {
            exist.append(number)
        }
        
    }
    return exist.reduce(0, +)
}

print(multiples3and5(max: maxNumber))

