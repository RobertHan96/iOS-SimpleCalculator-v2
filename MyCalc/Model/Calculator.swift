import UIKit
import RealmSwift

class CalClass {
    var num1 = ""
    var num2 = ""
    var floatNum1 : Float = 0
    var floatNum2 : Float = 0
    var op = ""
    var formula = ""
    var operaters : [String] = ["+", "-", "*", "%", "/", "X"]
    var numbers : [Float] = []

    
    func isCalculable(inputNum : String) -> String {
//      첫번째값에 추가해야하는 경우 : 1,  두번째값인 경우 : 2, 연산기호일 경우 : 3을 결과로 리턴
//      =을 입력해서 계산해야할 경우 : 0, 에러 발생시 : -1
        if operaters.contains(inputNum) == false && num2 == "" && op == "" && inputNum != "="
        { return "1" }
        else if operaters.contains(inputNum) == false && op != "" && inputNum != "="
        { return "2" }
        else if operaters.contains(inputNum) == true && num2 == "" && inputNum != "="
        { return "3" }
        else if inputNum == "=" && num2 != "" {
            return "0"
        }
        else if operaters.contains(inputNum) == true && num1 == ""
        { return "-1" }
        
        return "-1"
    }
    
    func calc() -> String {
        var result : Float = 0
        switch op {
        case "+":
            result = floatNum1 + floatNum2
        case "-":
            result = floatNum1 - floatNum2
        case "X":
            result = floatNum1 * floatNum2
        case "/":
            result = floatNum1 / floatNum2
        case "%":
            result = Float(Int(floatNum1) % Int(floatNum2))
        default:
            result = floatNum1 + floatNum2
        }
        return String(result)
    }
    
    func clearNumbers() {
        num1 = ""
        num2 = ""
        floatNum1 = 0
        floatNum2 = 0
        op = ""
    }

    // 계산식, 결과값을 Realm에 추가
    func saveData(fomula : String) {
        let calcValue = CalcHistory()
        //realm 기본 객체 얻어오기
        let date = Date()
        let formatter = DateFormatter() // 현재시간 출력을 위한 데이터 포맷팅
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        let currentDate = formatter.string(from: date)
        
        calcValue.date = currentDate
        calcValue.result = fomula
        let realm = try! Realm() // realm 불러오기
        //write 트랜젝션으로 위에서 불러온 값 저장
        try! realm.write {
            realm.add(calcValue)
            }
        }
    
} // CalClass 끝나는 부분

class CalcHistory: Object {
    @objc dynamic var result : String = "" // 계산식 저장용 필드
    @objc dynamic var date : String = "" // 현재 시각 저장용 필드
    // 계산 결과값 저장용 필드
//    @objc dynamic var value : Float = 0.0
    
}
