/**
 Week 1 __   Day 1 __ Q-1
 */

let stringFirst = "aaba kouq bux"

func deleteDublicates(string: String, repeatCount: Int) -> String{
    var nonRepeated: String = ""
    
    for character in string {
        
        var repeated: Int = 0
        
        for watch in string {
            if watch == character && watch != " " {
                repeated += 1
            }
        }
        
        if repeated < repeatCount {
            nonRepeated.append(character)
        }
        
    }
    return nonRepeated
}

print(deleteDublicates(string: stringFirst, repeatCount: 4))

