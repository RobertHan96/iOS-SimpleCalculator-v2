import Foundation
import UIKit
import RealmSwift
import Toast_Swift

var CalInfo : CalClass = CalClass() // 계산에 필요한 클래스 상속

let realm = try! Realm()
let config = Realm.Configuration( //버전, 마이그레이션 관리용 코드
    schemaVersion: 2,
    migrationBlock: { migration, oldSchemaVersion in
      if oldSchemaVersion < 2 {
      }
    })

class MainViewController: UIViewController {
    @IBOutlet weak var labelResult: UILabel!
    @IBOutlet weak var btnDivision: UIButton!
    @IBOutlet weak var btnRemainder: UIButton!
    @IBOutlet weak var btnHistory: UIButton!
    @IBOutlet weak var btnClear: UIButton!
    @IBOutlet weak var btnMultiple: UIButton!
    @IBOutlet weak var btnPlus: UIButton!
    @IBOutlet weak var btnMinus: UIButton!
    @IBOutlet weak var btnEqual: UIButton!
    @IBOutlet weak var btnPoint: UIButton!
    
    @IBOutlet weak var btnZero: UIButton!
    @IBOutlet weak var btnOne: UIButton!
    @IBOutlet weak var btnTwo: UIButton!
    @IBOutlet weak var btnThree: UIButton!
    @IBOutlet weak var btnFour: UIButton!
    @IBOutlet weak var btnFive: UIButton!
    @IBOutlet weak var btnSix: UIButton!
    @IBOutlet weak var btnSeven: UIButton!
    @IBOutlet weak var btnEight: UIButton!
    @IBOutlet weak var btnNine: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Realm.Configuration.defaultConfiguration = config
        setupUI()
}
    // 각 숫자들을 입력 받는 함수
    @IBAction func btnNum(_ sender : UIButton) {
        if labelResult.text == "0" &&  sender.currentTitle == "0" {
            self.view.makeToast("입력된 값이 없음", duration: 3.0)
        }
        else if labelResult.text == "0" {
            labelResult.text = sender.currentTitle!
            CalInfo.arraryTmp.append(sender.currentTitle!)
        
        }
        else {
            labelResult.text = labelResult.text! + sender.currentTitle!
            CalInfo.arraryTmp.append(sender.currentTitle!)
        }
    }
    // '='버튼 터치시 계산(Calc) 함수 호출, 연산자 버튼 터치시 숫자 읽기(getNum) 함수 호출
    @IBAction func operation(_ sender : UIButton) {
        if CalInfo.OPSize <= 1 {
            if sender.currentTitle == "+" {
                CalInfo.getNum(operation: "+", label: labelResult)
            } else if  sender.currentTitle == "-" {
                CalInfo.getNum(operation: "-", label: labelResult)
            } else if sender.currentTitle == "X" {
                CalInfo.getNum(operation: "X", label: labelResult)
            }  else if sender.currentTitle == "/" {
                CalInfo.getNum(operation: "/", label: labelResult)
            }  else if sender.currentTitle == "%" {
                CalInfo.getNum(operation: "%", label: labelResult)
            } else if sender.currentTitle == "="{
                let arrSize = CalInfo.arrSize
                if arrSize == 0  { //앱실행후 처음 연산할 경우
                    self.view.makeToast("연산할 다른 숫자를 입력하세요", duration: 3.0)
                } else if (CalInfo.arrSize) > 0 && CalInfo.arrSize < 3 { // 계산 할 수 있는 상황이라면 print로 로그를 남기고, 계산을 수행
                    CalInfo.saveData(label: labelResult, value: (CalInfo.arraryNum.last!))
                            print("첫번째 연산입니다.")
                            print("배열에 저장중인 값 : \(CalInfo.arraryNum)")
                            
                            let realmValue = realm.objects(CalcHistory.self).last
                            let valueResult = realmValue?.result
                            let calcTime = realmValue?.date
                            print("realm에 저장중인 값 : \(valueResult)")
                            print("realm에 저장중인 값 : \(calcTime)")
                            CalInfo.clac(label: labelResult)
                    } else { //첫번째 이후의 계산일 경우 계산만 함
                        CalInfo.saveData(label: labelResult, value: (CalInfo.arraryNum.last!))
                        CalInfo.clac(label: labelResult)
                    }
            } // '=' 버튼 입력시 실행되는 코드 블록 끝나는 부분
        }
        // 연산 문자를 연속해서 입력할 경우 방지 2번까지는 입력 가능해서 수정 필요
        else if CalInfo.OPSize > 1  {
            let latestNum = "\(CalInfo.arraryNum.last ?? 0)"
            self.view.makeToast("=를 눌러 먼저 계산해주세요", duration: 3.0)
            labelResult.text = latestNum + CalInfo.arraryOP[CalInfo.OPSize-2]
        if labelResult.text == "0"  {
            self.view.makeToast("계산할 값이 없음", duration: 3.0)
        }
        }

    } //버튼 액션 함수 끝나는 부분
    
    // 소수점 표시 버튼
    @IBAction func btnPoint(_ sender: Any) {
        if labelResult.text == "0" {
            self.view.makeToast("소수점을 추가할 값이 없음", duration: 3.0)
        } else {
            labelResult.text = labelResult.text! + "."
            CalInfo.arraryTmp.append(".")
        }
    }
    // 화면에 표시된 숫자 전체 삭제
    @IBAction func btnClear(_ sender: Any) {
        CalInfo.clearData(label: labelResult)
    }
    // 기록뷰를 보고 오면 입력되었던 tmpValue1가 사라지도록 함수 실행
    @IBAction func btnHistory(_ sender: Any) {
        CalInfo.clearData(label: labelResult)
    }
    
    func setupUI(){
        btnZero.layer.cornerRadius = btnZero.bounds.width/2
        btnOne.layer.cornerRadius = btnOne.bounds.width/4
        btnTwo.layer.cornerRadius = btnTwo.bounds.width/4
        btnThree.layer.cornerRadius = btnThree.bounds.width/4
        btnFour.layer.cornerRadius = btnFour.bounds.width/4
        btnFive.layer.cornerRadius = btnFive.bounds.width/4
        btnSix.layer.cornerRadius = btnSix.bounds.width/4
        btnSeven.layer.cornerRadius = btnSeven.bounds.width/4
        btnEight.layer.cornerRadius = btnEight.bounds.width/4
        btnNine.layer.cornerRadius = btnNine.bounds.width/4
        btnClear.layer.cornerRadius = btnClear.bounds.width/4
        btnHistory.layer.cornerRadius = btnHistory.bounds.width/4
        btnRemainder.layer.cornerRadius = btnRemainder.bounds.width/4
        btnDivision.layer.cornerRadius = btnDivision.bounds.width/4
        btnMultiple.layer.cornerRadius = btnMultiple.bounds.width/4
        btnPlus.layer.cornerRadius = btnPlus.bounds.width/4
        btnMinus.layer.cornerRadius = btnMinus.bounds.width/4
        btnEqual.layer.cornerRadius = btnEqual.bounds.width/2
        btnPoint.layer.cornerRadius = btnPoint.bounds.width/2

    }
}
