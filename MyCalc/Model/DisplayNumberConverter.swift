import Foundation

struct DisplayNumberConverter {
    var number : Float
    
    func isHasPoint() -> Bool {
        var isHasPoint = false
        if String(number).contains(".") {
            isHasPoint = true
        }
        return isHasPoint
    }

    func islookLikeFloat() -> Bool {
        let numberToString = String(number)
        var islookLikeFloat = true

        if isHasPoint() == true {
            guard let pointOfNumber = numberToString.split(separator: ".").last else { return false}
            let pointToInt = Int(String(pointOfNumber))!
            if pointToInt != 0 {
                islookLikeFloat = false
            }
        }
        return islookLikeFloat
    }

    func convertNumberToDisplayString() -> String {
        var numberToDisplayString = ""
        
        if islookLikeFloat() == true {
            numberToDisplayString = String(Int(number))
        } else {
            numberToDisplayString = String(format: "%.2f", number)
        }
        return numberToDisplayString
    }
}
