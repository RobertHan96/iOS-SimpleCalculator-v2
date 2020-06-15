import UIKit
import RealmSwift

class CalClass {

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
