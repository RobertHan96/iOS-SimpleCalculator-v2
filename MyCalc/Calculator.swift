import UIKit
import RealmSwift
import RealmSwift
import Toast_Swift

class CalClass {
    var arraryTmp: [String] = [] //레이블로 입력된 텍스트값 임시 저장 배열
    var arraryOP: [String] = [] // 사용자가 누른 연산자 저장용 배열
    var arraryNum : [Float] = [] // arraryTmp의 문자를 반복문으로 돌린 후 Float로 저장하는 실제 값 배열
    var arrSize : Int {
        get {
            return arraryNum.count
        }

    }
    var OPSize : Int {
        get {
            return arraryOP.count
        }

    }
    var tmpValue1 : String = "" // 사용자가 입력한 값을 임시로 저장하는 배열 : String
    var tmpValue2 : String = "" // 사용자가 입력한 값을 임시로 저장하는 배열 : String
    // 계산과 관련된 모든 배열을 초기화하는 함수
    func clearData(label:UILabel) {
        label.text = "0"
        tmpValue1 = ""
        tmpValue2 = ""
        arraryOP.removeAll()
        arraryTmp.removeAll()
        arraryNum.removeAll()
        print("저장된 숫자 : \(arraryNum) 저장된 연산 기호 : \(arraryOP)")
    }
    
    func clearNumbers() {
        arraryTmp.removeAll()
        arraryNum.removeAll()
    }
    // 버튼 입력을 받아 배열에 추가하고, 디스플레이 레이블에 표시함
    func getNum(operation : String, label:UILabel) {
        arraryOP.append(operation)
        for i in arraryTmp { // 입력된 버튼값을 arraryTmp 배열에 1개씩 추가
            tmpValue1 += i // 각 배열요소를 1개의 tmpValue1에 저장
        }
        if tmpValue1 == "" && arraryNum.count == 0 {
            // 입력된 숫자가 없는 상태에서 연산 시도시 에러 안내문구 출력
            print("연산할 다른 숫자를 입력하세요")
        } else if (arraryNum.count) >= 2 {
            print("값 저장됨 (첫번째 연산) : \(tmpValue1)")
            arraryNum.append(arraryNum.last!)
            arraryTmp.removeAll()
        }
        else {
            print("첫번째 값 저장됨 : \(tmpValue1)")
            arraryNum.append(Float(tmpValue1)!) // 위에서 removeall을해 nil값 오류 발생
            arraryTmp.removeAll()
        }
        label.text = label.text! + operation
        print("첫번째 값 저장 결과, 배열에 있는 숫자 : \(arraryNum)")

        }
    // 이전에 눌렸던 연산자를 기준으로 숫자 계산 진행
    func clac(label : UILabel) {
        tmpValue2 = ""
        for i in arraryTmp {
            tmpValue2 += i
        }
        if tmpValue2 == "" { // 두번째값이 입력 전이라면 안내문구를 출력
            print("연산할 다른 숫자를 입력하세요 - clac에서 호출")
        }
        else if arrSize > 0 && arrSize < 3{ //두번째 값이 정상적으로 입력되었다면 계산 코드를 수행
            calcCore(tmp1: 1, tmp2: 2, label: label)
        } // arrSize > 0 &&  < 3 이상인 조건 끝나는 부분
        else if arrSize >= 3 {
            calcCore(tmp1: 1, tmp2: 2, label: label)
        } else {
            print("예외상황 오류 발생 - calc에서 호출")
        }
        
    }
    
    func calcCore(tmp1: Int, tmp2: Int, label : UILabel) {
        print(tmpValue2)
        arraryNum.append(Float(tmpValue2)!)
        print("배열에 저장중인 값 : \(arraryNum)")
        let tmp1 = arraryNum[arrSize-tmp1] //클래스에서 arraryNum.count로 값 할당 필요
        let tmp2 = arraryNum[arrSize-tmp2]
        if arraryOP.last == "+" {
            label.text = String(tmp1+tmp2)
        }else if arraryOP.last == "-"{
            label.text = String(-(tmp1-tmp2))
        } else if arraryOP.last == "X" {
            label.text = String(tmp1*tmp2)
        } else if arraryOP.last == "/" {
            label.text = String(tmp1/tmp2)
        } else if arraryOP.last == "%" {
            label.text = String(Int(tmp2)%Int(tmp1))
        }
        arraryTmp.removeAll()
        arraryOP.removeAll()
        // 계산결과를 arrayNum배열에 추가하고 프린트문으로 확인하는 부분
        arraryNum.append(Float(label.text!)!)
        print("계산결과 : \(arraryNum.last!)")
        
        let realmValue = realm.objects(CalcHistory.self).last
        let changeValue = Float((arraryNum.last!))
         try! realm.write {
             realmValue!.value = changeValue
            }
        }
    // 계산식, 결과값을 Realm에 추가
    func saveData(label : UILabel, value : Float) {
        let calcValue = CalcHistory()
        //realm 기본 객체 얻어오기
        let date = Date()
        let formatter = DateFormatter() // 현재시간 출력을 위한 데이터 포맷팅
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        let resultDate = formatter.string(from: date)
        
        calcValue.date = resultDate // 현재 시간을 date 필드에 저장
        calcValue.result = label.text! // 계산식(레이블)값을 result 필드에 저장
        calcValue.value = value
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
    @objc dynamic var value : Float = 0.0 // 계산 결과값 저장용 필드
    
}
