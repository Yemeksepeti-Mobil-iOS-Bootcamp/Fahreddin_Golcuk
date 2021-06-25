/**
 Week 1 __   Day 1 __ Q-2
 */

let stringSecond = "merhaba nasılsınız . iyiyim siz nasılsınız . bende iyiyim"

func repeatedWords(string: String) -> [String: Int]{
    var words = [String : Int]()
    let stringToArray = string.split(separator: " ")
    
    for word in stringToArray {
        
        let selected = word
        var repeated = 0
        
        for search in stringToArray {
            if search == selected {
                repeated += 1
            }
        }
        
        words[String(word)] = repeated
    }
    return words
}

print(repeatedWords(string: stringSecond))
