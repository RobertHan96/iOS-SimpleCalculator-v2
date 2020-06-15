import Foundation
import UIKit
import RealmSwift
import Toast_Swift

var Cal : CalClass = CalClass() // 계산에 필요한 클래스 상속
let realm = try! Realm()
let config = Realm.Configuration( //버전, 마이그레이션 관리용 코드
    schemaVersion: 3,
    migrationBlock: { migration, oldSchemaVersion in
      if oldSchemaVersion < 3 {
      }
    })

class MainViewController: UIViewController {
    @IBOutlet weak var labelResult: UILabel!

    var num1 = ""
    var num2 = ""
    var floatNum1 : Float = 0
    var floatNum2 : Float = 0
    var op = ""
    var formula = ""
    var operaters : [String] = ["+", "-", "*", "%", "/", "X"]
    var numbers : [Float] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        Realm.Configuration.defaultConfiguration = config
    }
    // 각 숫자들을 입력 받는 함수
    @IBAction func btnNum(_ sender : UIButton) {
        let input = sender.currentTitle!
        if operaters.contains(sender.currentTitle!) == true && num1 == "" {
            print("에러 : 연산자가 먼저 입력됨")
        } else if isCalculable(inputNum: input) == "1" {
            labelResult.text! += input
            num1 += input
        } else if isCalculable(inputNum: input) == "2" {
            labelResult.text! += input
            num2 += input
        } else if isCalculable(inputNum: input) == "3" {
            if op.count >= 1 {
                print("에러 : 이미 입력한 연산자가 존재함")
                return
            } else {
                labelResult.text! += input
                op = input
            }
        } else if isCalculable(inputNum: input) == "0" {
                floatNum1 = Float(num1)!
                floatNum2 = Float(num2)!
                let calcResult = calc(n1: floatNum1, n2: floatNum2, op: op)
                labelResult.text! = calcResult
                formula = "\(num1)\(op)\(num2) = \(calcResult)"
                clearNumbers()
                num1 = calcResult
                Cal.saveData(fomula: formula)
        } else {
            print("에러 : 계산을 수행하지 못함")
        }
        
        print("1번 숫자:\(num1), 2번 숫자:\(num2), 연산자:\(op)")
    }
        
    
    func calc(n1 : Float, n2 : Float, op : String) -> String {
        var result : Float = 0
        switch op {
        case "+":
            result = n1 + n2
        case "-":
            result = n1 - n2
        case "X":
            result = n1 * n2
        case "/":
            result = n1 / n2
        case "%":
            result = Float(Int(n1) % Int(n2))
        default:
            result = n1 + n2
        }
        return String(result)
    }
    
    // 소수점 표시 버튼
    @IBAction func btnPoint(_ sender: Any) {
        if labelResult.text == "0" {
            self.view.makeToast("소수점을 추가할 값이 없음", duration: 3.0)
        } else {
            labelResult.text! += "."
            if num2 == "" {
                num1 += "."
            } else {
                num2 += "."
            }
        }
        print("1번 숫자-\(num1), 2번 숫자-\(num2), 연산자-\(op)")
    }
    
    // 화면에 표시된 숫자 전체 삭제
    @IBAction func btnClear(_ sender: Any) {
        clearNumbers()
        labelResult.text = ""
    }
    
    @IBAction func btnHistory(_ sender: Any) {

    }
    
    func clearNumbers() {
        num1 = ""
        num2 = ""
        floatNum1 = 0
        floatNum2 = 0
        op = ""
    }
        
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
    
}
