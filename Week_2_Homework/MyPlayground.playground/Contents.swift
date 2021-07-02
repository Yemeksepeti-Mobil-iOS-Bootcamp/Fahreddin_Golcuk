import Foundation
/**
 Girilen bir sayının asal olup olmadığını bulan bir extension yazınız.
 */
extension Int {
    func primeCheck() -> Bool {
        var isDivided: Bool = false
        if self <= 2 {
            if self == 2{
                return true
            } else {
                return false
            }
        }
        for index in 2...self - 1 {
            if(self % index == 0) {
                isDivided = true
            }
        }
        return !isDivided
    }
    
    func pow(_ pow: Int) -> Int { //need for euler problem 6
        var result = 1
        for _ in 0...pow - 1 {
            result *= self
        }
        return result
    }
}

17.primeCheck()


///


/**
 İki parametreli ve FARKLI tipli bir generic örneği yapınız... (T, U) ???
 ---Function that repeats the entered value---
 */

func loggerRepeatedItem<T: Strideable,U>(count:T, repeated: U) {
    for _ in stride(from: 0, to: count as! Int, by: 1) {
        print(repeated)
    }
}

loggerRepeatedItem(count: 3, repeated: 4)



/**
 static : used to create type properties with either let or var. These are shared between all objects of a class.Static Variables are belong to a type rather than to instance of class. You can access the static variable by using the full name of the type.
 */

class API {
    static let API_KEY = "123123asd123asd"
    func post() -> Bool{
        return true
    }
    func get() ->Bool {
        return false
    }
}

let api = API()
api.get()
api.post()
API.API_KEY


/**
 Project Euler Problem 6
 --Find the difference between the sum of the squares of the first one hundred natural numbers and the square of the sum.
 */

func differentSquare() -> Int {
    var sumOfTheSquares: Int = 0
    for index in 1...100 {
        sumOfTheSquares += (index * index)
    }
    let squareOfTheSum: Int = ((100*101)/2).pow(2)
    return squareOfTheSum - sumOfTheSquares
}

differentSquare()


/**
 Project Euler Problem 7
 --What is the 10 001st prime number?
 */

func findPrimeNumberByIndex(index: Int) -> Int{
    var number: Int = 0
    var primeIndex: Int = 1
    if index <= 0 { //index out of bounds
        return 0
    }
    while true { //increase primeIndex when index not equal to wanted index
        if(number.primeCheck()){
            if(index == primeIndex){
                break
            } else{
                primeIndex += 1
            }
        }
        number+=1
    }
    return number
}

findPrimeNumberByIndex(index: 2)

/**
IF LET - GUARD LET USES CASES
 
Yalnızca bazı durumlarda koşulun içini açmak için  if let'i kullanılır,  ancak devam etmeden önce bu koşulların doğru olup olmadığını özellikle kontrol ediyorsanız guard let  tercih edilebilir.
 
 */




