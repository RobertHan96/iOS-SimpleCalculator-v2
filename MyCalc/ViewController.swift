import Foundation
import UIKit
import RealmSwift
import Toast_Swift

var textNumbers: [String] = [] //레이블로 입력된 텍스트값 임시 저장 배열
var arraryOP: [String] = [] // 사용자가 누른 연산자 저장용 배열
var arraryNum : [Float] = [] // textnumbers의 문자를 반복문으로 돌린 후 Float로 저장되는 실제 값 배열
var textValue : String = ""
var textValue2 : String = ""
let op1 = "+"
let op2 = "-"
let op3 = "/"
let op4 = "%"
let op5 = "X"

let realm = try! Realm()
let config = Realm.Configuration( //버전, 마이그레이션 관리용 코드
  schemaVersion: 2,
  migrationBlock: { migration, oldSchemaVersion in
    if oldSchemaVersion < 2 {
    }
  })
    

func saveDate(labeValue : UILabel, value : Float) {
    let calcValue = CalcHistory()
    //realm 기본 객체 얻어오기
    let date = Date()
    let formatter = DateFormatter() // 현재시간 출력을 위한 데이터 포맷팅
    formatter.dateFormat = "yyyy-MM-dd HH:mm"
    let resultDate = formatter.string(from: date)
    
    calcValue.date = resultDate // 현재 시간을 date 필드에 저장
    calcValue.result = labeValue.text! // 계산식(레이블)값을 result 필드에 저장
    calcValue.value = value
    let realm = try! Realm() // realm 불러오기
    //write 트랜젝션으로 위에서 불러온 값 저장
    try! realm.write {
        realm.add(calcValue)
    }
}



class ViewController: UIViewController {
    @IBOutlet weak var labelResult: UILabel!
    
    func clearData() {
        labelResult.text = "0"
        arraryOP.removeAll()
        textNumbers.removeAll()
        arraryNum.removeAll()
        print("저장된 숫자 : \(arraryNum) 저장된 연산 기호 : \(arraryOP)")

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Realm.Configuration.defaultConfiguration = config
        
}
        
    // 각 숫자들을 입력 받는 함수
    @IBAction func btnNum(_ sender : UIButton) {
        if labelResult.text == "0" &&  sender.currentTitle == "0" {
            self.view.makeToast("입력된 값이 없음", duration: 3.0)
        }
        else if labelResult.text == "0" {
            labelResult.text = sender.currentTitle!
            textNumbers.append(sender.currentTitle!)
        
        }
        else {
            labelResult.text = labelResult.text! + sender.currentTitle!
            textNumbers.append(sender.currentTitle!)

        }

    }
    

    @IBAction func operation(_ sender : UIButton) {
        if labelResult.text == "0"  {
            self.view.makeToast("계산할 값이 없음", duration: 3.0)
        } else if sender.currentTitle == "+" {
            getNum(operation: "+")
        } else if  sender.currentTitle == "-" {
            getNum(operation: "-")
        } else if sender.currentTitle == "X" {
            getNum(operation: "X")
        }  else if sender.currentTitle == "/" {
            getNum(operation: "/")
        }  else if sender.currentTitle == "%" {
            getNum(operation: "%")
        } else if sender.currentTitle == "="{
            let arrSize = arraryNum.count
            if arrSize == 0  { //앱실행후 처음 연산할 경우
                self.view.makeToast("연산할 다른 숫자를 입력하세요 arrSize<=1", duration: 3.0)
            } else if arrSize > 0 && arrSize < 3 { // 계산 할 수 있는 상황이라면 print로 로그를 남기고, 계산을 수행
                    saveDate(labeValue: labelResult, value: arraryNum.last!)
                        print("첫번째 연산입니다.")
                        print("배열에 저장중인 값 : \(arraryNum)")
                        
                        let realmValue = realm.objects(CalcHistory.self).last
                        let valueResult = realmValue?.result
                        let calcTime = realmValue?.date
                        print("realm에 저장중인 값 : \(valueResult)")
                        print("realm에 저장중인 값 : \(calcTime)")
                        clac()
                } else { //첫번째 이후의 계산일 경우 계산만 함
                    saveDate(labeValue: labelResult, value: arraryNum.last!)
                    clac()
                }

        } // '=' 버튼 입력시 실행되는 코드 블록 끝나는 부분

        
    } //버튼 액션 함수 끝나는 부분
    
    
    func getNum(operation : String) {
        arraryOP.append(operation)
        for i in textNumbers { // 입력된 버튼값을 textNumbers 배열에 1개씩 추가
            textValue += i // 각 배열요소를 1개의 textValue에 저장
        }
        if textValue == "" && arraryNum.count == 0 {
            // 입력된 숫자가 없는 상태에서 연산 시도시 에러 안내문구 출력
            self.view.makeToast("연산할 다른 숫자를 입력하세요", duration: 3.0)
        } else if arraryNum.count >= 2 {
            //
            print("값 저장됨 (두번째 이후 연산) : \(textValue)")
            arraryNum.append(arraryNum.last!)
            textNumbers.removeAll()
            textValue = ""
        } else {
            print("첫번째 값 저장됨 : \(textValue)")
            arraryNum.append(Float(textValue)!)
            textNumbers.removeAll()
            textValue = ""
        }
        labelResult.text = labelResult.text! + operation
        print("첫번째 값 저장 결과, 배열에 있는 숫자 : \(arraryNum)")
    }
    
    func clac() {
        textValue2 = ""
        for i in textNumbers {
            textValue2 += i
        }
        if textValue2 == "" { // 두번째값이 입력 전이라면 안내문구를 출력
            self.view.makeToast("연산할 다른 숫자를 입력하세요 clac", duration: 3.0)
        } else { //두번째 값이 정상적으로 입력되었다면 계산 코드를 수행
            print(textValue2)
            arraryNum.append(Float(textValue2)!)
            print("배열에 저장중인 값 : \(arraryNum)")
            
            let arrSize = arraryNum.count
            let tmp1 = arraryNum[arrSize-1]
            let tmp2 = arraryNum[arrSize-2]
            
            if arraryOP.last == "+" {
                labelResult.text = String(tmp1+tmp2)
                textNumbers.removeAll()
                arraryOP.removeAll()
                
            }else if arraryOP.last == "-"{
                arraryOP.removeAll()
                labelResult.text = String(-(tmp1-tmp2))
                textNumbers.removeAll()

            } else if arraryOP.last == "X" {
                labelResult.text = String(tmp1*tmp2)
                textNumbers.removeAll()
                arraryOP.removeAll()
            } else if arraryOP.last == "/" {
                labelResult.text = String(tmp1/tmp2)
                textNumbers.removeAll()
                arraryOP.removeAll()
            } else if arraryOP.last == "%" {
                labelResult.text = String(Int(tmp2)%Int(tmp1))
                textNumbers.removeAll()
                arraryOP.removeAll()
            } else {
                self.view.makeToast("에러가 발생했습니다", duration: 3.0)
                
            }
            
            // 계산결과를 arrayNum배열에 추가하고 프린트문으로 확인하는 부분
            arraryNum.append(Float(labelResult.text!)!)
            print("계산결과 : \(arraryNum.last!)")
            
            let realmValue = realm.objects(CalcHistory.self).last
            let changeValue = Float(arraryNum.last!)
             try! realm.write {
                 realmValue!.value = changeValue
             }

            
            print("realm에 저장된 계산 결과값\(changeValue)")
            textNumbers.removeAll()

        }
        
    }

    // 소수점 표시 버튼
    @IBAction func btnPoint(_ sender: Any) {
        if labelResult.text == "0" {
            self.view.makeToast("소수점을 추가할 값이 없음", duration: 3.0)
        } else {
            labelResult.text = labelResult.text! + "."
            textNumbers.append(".")
        }
        
    }
    
    // 화면에 표시된 숫자 전체 삭제
    @IBAction func btnClear(_ sender: Any) {
        clearData()

    }
    
    @IBAction func btnHistory(_ sender: Any) { // 기록뷰를 보고 오면 입력값 사라지도록 함수 실행
        clearData()
    }
    
    

}
