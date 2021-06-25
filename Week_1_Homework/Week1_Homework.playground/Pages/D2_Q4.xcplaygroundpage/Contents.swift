/**
 Week 1 __ Day 2 __  Project Euler - Q4
 */

func largestPalindrome3digit() -> Int {
    var result: Int = 0
    
    for digit1 in stride(from: 999, through: 100, by: -1){
        
        for digit2 in stride(from: 999, through: 100, by: -1){
            
            let number: String = String(digit1 * digit2)
            var reverseNumber: String = ""
            
            String(number).utf8.map{Int($0)-48}.reduce([],{ [$1] + $0 }).map{ reverseNumber = reverseNumber + "\($0)" }
            if(number == reverseNumber) {
                result = Int(number) ?? 0
                break
            }
            
        }
    }
    return result
}

print(largestPalindrome3digit())
