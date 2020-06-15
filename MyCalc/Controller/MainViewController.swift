import Foundation
import UIKit
import RealmSwift

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

    override func viewDidLoad() {
        super.viewDidLoad()
        Realm.Configuration.defaultConfiguration = config
    }
    
    // 숫자, 연산자, = 을 입력 받아 리턴 코드에 따른 작업을 수행하는 함수
    @IBAction func btnNum(_ sender : UIButton) {
        let input = sender.currentTitle!
        if Cal.operaters.contains(input) == true && Cal.num1 == "" {
            print("에러 : 연산자가 먼저 입력됨")
        } else if Cal.isCalculable(inputNum: input) == "1" {
            labelResult.text! += input
            Cal.num1 += input
        } else if Cal.isCalculable(inputNum: input) == "2" {
            labelResult.text! += input
            Cal.num2 += input
        } else if Cal.isCalculable(inputNum: input) == "3" {
            if Cal.op.count >= 1 {
                print("에러 : 이미 입력한 연산자가 존재함")
                return
            } else {
                labelResult.text! += input
                Cal.op = input
            }
        } else if Cal.isCalculable(inputNum: input) == "0" {
                Cal.floatNum1 = Float(Cal.num1)!
                Cal.floatNum2 = Float(Cal.num2)!
                let calcResult = Cal.calc()
                labelResult.text! = calcResult
                Cal.formula = "\(Cal.num1)\(Cal.op)\(Cal.num2) = \(calcResult)"
                Cal.clearNumbers()
                Cal.num1 = calcResult
                Cal.saveData(fomula: Cal.formula)
        } else {
            print("에러 : 계산을 수행하지 못함")
        }
        
        print("1번 숫자:\(Cal.num1), 2번 숫자:\(Cal.num2), 연산자:\(Cal.op)")
    }
        
    // 소수점 표시 여부를 검사하는 액션 함수
    @IBAction func btnPoint(_ sender: Any) {
        if labelResult.text == "" {
            print("에러 : 소수점을 추가할 값이 없음")
        } else {
            labelResult.text! += "."
            if Cal.num2 == "" {
                Cal.num1 += "."
            } else {
                Cal.num2 += "."
            }
        }
        print("1번 숫자:\(Cal.num1), 2번 숫자:\(Cal.num2), 연산자:\(Cal.op)")
    }
    
    // 화면에 표시된 숫자, Cal클래스내 맴버 변수 전체 삭제
    @IBAction func btnClear(_ sender: Any) {
        Cal.clearNumbers()
        labelResult.text = ""
    }
    
    @IBAction func btnHistory(_ sender: Any) { }
    
}
