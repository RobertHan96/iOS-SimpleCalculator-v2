import Foundation
import UIKit

class Anims {
    static func notifiyMaxTextLengthAnim(cv : UIView) {
        UIView.animate(withDuration: 1.0) {
            cv.alpha = 0.5
            cv.alpha = 1.0
        }
    }
}
