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
        labelResult.adjustsFontSizeToFitWidth = true
    }
    
    // 숫자, 연산자, = 을 입력 받아 리턴 코드에 따른 작업을 수행하는 함수
    @IBAction func btnNum(_ sender : UIButton) {
        guard let inputLen = labelResult.text else { return} // 입력받은 label nil 체크
        if inputLen.count > 10 {
            print("[Log] 9자리 이상 수식 입력 불가")
            Anims.notifiyMaxTextLengthAnim(cv: self.view)
        } else {
            guard let input = sender.currentTitle else {return }// 숫자보다 연산자가 먼저 입력됐는지 검사
            if Cal.operaters.contains(input) == true && Cal.num1 == "" {
                print("[Log] 연산자가 먼저 입력됨")
            }else if Cal.isCalculable(inputNum: input) == "1" {
                labelResult.text! += input
                Cal.num1 += input
            } else if Cal.isCalculable(inputNum: input) == "2" {
                labelResult.text! += input
                Cal.num2 += input
            } else if Cal.isCalculable(inputNum: input) == "3" {
                if Cal.op.count >= 1 {
                    print("[Log] 이미 입력한 연산자나 소수점이 존재함")
                } else if Cal.num1.last == "."{
                    print("[Log] 소수 점 뒤 값 입력전에 연산자 입력 불가")
                } else {
                    labelResult.text! += input
                    Cal.op = input
                }
            } else if Cal.isCalculable(inputNum: input) == "0" {
                if Cal.num1.last == "." || Cal.num2.last == "." {
                    print("[Log] 소수 점 뒤 값 입력전에 계산 불가")
                } else {
                    if Cal.num1 == "0" && Cal.num2 == "0" {
                        print("[Log] 계산가능한 숫자가 모자람")
                    }
                    else {
                        Cal.floatNum1 = Float(Cal.num1)!
                        Cal.floatNum2 = Float(Cal.num2)!
                        let calcResult = Cal.calc()
                        labelResult.text! = calcResult
                        Cal.formula = "\(Cal.num1)\(Cal.op)\(Cal.num2) = \(calcResult)"
                        Cal.clearNumbers()
                        Cal.num1 = calcResult
                        Cal.saveData(fomula: Cal.formula)
                    }
                }

            } else {
                print("[Log] 계산을 수행하지 못함")
            }
            
            print("[Log] 1번 숫자:\(Cal.num1), 2번 숫자:\(Cal.num2), 연산자:\(Cal.op)")
        }

    }
        
    // 소수점 표시 여부를 검사하는 액션 함수
    @IBAction func btnPoint(_ sender: Any) {
        Cal.makePoint(lable: labelResult)
    }
    
    // 화면에 표시된 숫자, Cal클래스내 맴버 변수 전체 삭제
    @IBAction func btnClear(_ sender: Any) {
        Cal.clearNumbers()
        labelResult.text = ""
    }
    
    @IBAction func btnHistory(_ sender: Any) { }
    
}
