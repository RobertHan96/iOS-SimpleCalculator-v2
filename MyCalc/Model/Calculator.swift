import UIKit
import RealmSwift

class CalClass {
    var num1 = ""
    var num2 = ""
    var floatNum1 : Float = 0
    var floatNum2 : Float = 0
    var op = "" // 현재 계산해야할 연산자를 저장하는 문자열
    var formula = "" // 계산한식 전체를 저장하는 문자열 => Realm 저장용
    var operaters : [String] = ["+", "-", "*", "%", "/", "X"]
    
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
        let displayNumberConverter = DisplayNumberConverter(number: result)

        return displayNumberConverter.convertNumberToDisplayString()
    }
    
    func clearNumbers() {
        num1 = ""
        num2 = ""
        floatNum1 = 0
        floatNum2 = 0
        op = ""
    }

    func addPoint(lable : UILabel) {
        guard lable.text != nil else { return } // 입력받은 레이블 nil 체크
        lable.text! += "."
        if Cal.num2 == "" {
           Cal.num1 += "."
        } else {
           Cal.num2 += "."
        }
    }
    
    func makePoint(lable : UILabel)  {
        guard lable.text != nil else { return } // 입력받은 레이블 nil 체크
        let countDot = lable.text!.filter { (char) -> Bool in
            return char == "."}.count
        switch countDot {
            case 0:
                if num1 == "" {
                    print("[Log] 소수점을 추가할 수 있는 값이 없음")
                }
                else if num2 == "" && num1 != "" && op != "" {
                    print("[Log] 소수점을 추가할 수 있는 값이 없음")
                } else {
                    addPoint(lable: lable)
            }
            case 1:
                if op == "" {
                    print("[Log] 첫번째 값에는 더 이상 소수점 추가 불가")
                } else if num1.contains(".") == false {
                    print("[Log] 두번째 값에 더 이상 소수점 추가 불가")
                } else if num2 == "" {
                    print("[Log] 두번째 값에 더 이상 소수점 추가 불가")
                } else {
                    addPoint(lable: lable)
                }
            case 2:
                if num2 != "" && op != "" {
                    print("[Log] 두번째 값 입력 전에는 소수점 추가 불가")
                }
            default:
                addPoint(lable: lable)
            }
    }
    // 계산식, 결과값을 Realm에 추가
    func saveData(fomula : String) {
        let realmModel = CalcHistory()
        //realm 기본 객체 얻어오기
        let date = Date()
        let formatter = DateFormatter() // 현재시간 출력을 위한 데이터 포맷팅
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        let currentDate = formatter.string(from: date)
        
        realmModel.date = currentDate
        realmModel.result = fomula
        let realm = try! Realm() // realm 불러오기
        //write 트랜젝션으로 위에서 불러온 값 저장
        try! realm.write {
            realm.add(realmModel)
            }
    }
    
} // CalClass 끝나는 부분

class CalcHistory: Object {
    @objc dynamic var result : String = "" // 계산식 저장용 필드
    @objc dynamic var date : String = "" // 현재 시각 저장용 필드
    
}
