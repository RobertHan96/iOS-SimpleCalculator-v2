import UIKit
import RealmSwift

class Calculator {

}

class CalcHistory: Object {
    @objc dynamic var result : String = "" // 계산식 저장용 필드
    @objc dynamic var date : String = "" // 현재 시각 저장용 필드
    @objc dynamic var value : Float = 0.0 // 계산 결과값 저장용 필드
}
