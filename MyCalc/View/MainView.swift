import UIKit

class MainView: MainViewController {
    @IBOutlet weak var btnRemainder: UIButton!
    @IBOutlet weak var btnHistory: UIButton!
    @IBOutlet weak var btnClear: UIButton!
    @IBOutlet weak var btnMultiple: UIButton!
    @IBOutlet weak var btnPlus: UIButton!
    @IBOutlet weak var btnMinus: UIButton!
    @IBOutlet weak var btnEqual: UIButton!
    @IBOutlet weak var btnPoint: UIButton!
    @IBOutlet weak var btnDivision: UIButton!
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
        setupUI()
    }
    
    func setupUI() {
        var didRotate: (Notification) -> Void = { notification in
            switch UIDevice.current.orientation {
            case .landscapeLeft, .landscapeRight:
                self.setProperAutolayoutByOrientation(orientaion: "landscape")
            case .portrait, .portraitUpsideDown:
                self.setProperAutolayoutByOrientation(orientaion: "portrait")
            default:
                self.setProperAutolayoutByOrientation(orientaion: "landscape")
            }
        }
        
        NotificationCenter.default.addObserver(forName: UIDevice.orientationDidChangeNotification,
        object: nil,
        queue: .main,
        using: didRotate)
    }

    func setProperAutolayoutByOrientation(orientaion : String){
        let buttons : [UIButton?] = [
            btnZero, btnOne, btnTwo, btnThree, btnFour ,btnFive, btnSix, btnSeven, btnEight, btnNine, btnRemainder, btnHistory, btnClear, btnMultiple,
            btnPlus, btnMinus, btnMultiple, btnEqual, btnPoint, btnDivision
        ]
        let historyButtonInsetsDivider = getButtonInsetsDivider()
        let historyButtonImageInsetValue = btnHistory.bounds.width/historyButtonInsetsDivider
        btnHistory.imageEdgeInsets = UIEdgeInsets(top: historyButtonImageInsetValue, left: historyButtonImageInsetValue, bottom: historyButtonImageInsetValue, right: historyButtonImageInsetValue)
        
        if orientaion == "landscape" { //화면 방향에 따라 다르게 적용해야할 레이아웃 관련 옵션들 적용
            for button in buttons {
                if let btn = button {
                    btn.setFontSizeDependOnScreenSize(standardFontSize: 25)
                    btn.layer.cornerRadius = 10
                    btn.titleLabel?.adjustsFontForContentSizeCategory = true
                    btn.titleLabel?.adjustsFontSizeToFitWidth = true
                }
            }
        } else {
            for button in buttons {
                if let btn = button {
                    btn.setFontSizeDependOnScreenSize(standardFontSize: 60)
                    btn.layer.cornerRadius = 10
                    btn.titleLabel?.adjustsFontForContentSizeCategory = true
                    btn.titleLabel?.adjustsFontSizeToFitWidth = true
                }
            }
        }
    }
    
    func getButtonInsetsDivider() -> CGFloat{
        let currentDeviceModel = UIDevice.current.model
        switch currentDeviceModel {
            case "iPhone":
                return 4
            case "iPad":
                return 2
            default:
                return 4
        }
    }
}
    
extension UIButton {
    func setFontSizeDependOnScreenSize(standardFontSize : CGFloat) {
        let currentDeviceHeight = UIScreen.main.bounds.size.height
        let standardFontSize : CGFloat = standardFontSize // iphone 11Pro Max 기준
        var calculatedFont = UIFont.systemFont(ofSize: standardFontSize)
        
        switch currentDeviceHeight {
            case 480.0: //iphone 3,4S => 3.5 inch
                calculatedFont = UIFont.systemFont(ofSize: standardFontSize * 0.5)
                resizeFont(calculatedFont: calculatedFont)
                break
            case 568.0: //iphone 5, SE => 4 inch
                calculatedFont = UIFont.systemFont(ofSize: standardFontSize * 0.6)
                resizeFont(calculatedFont: calculatedFont)
                break
            case 667.0: //iphone 6, 6s, 7, 8 => 4.7 inch
                calculatedFont = UIFont.systemFont(ofSize: standardFontSize * 0.7)
                resizeFont(calculatedFont: calculatedFont)
                break
            case 736.0: //iphone 6s+ 6+, 7+, 8+ => 5.5 inch
                calculatedFont = UIFont.systemFont(ofSize: standardFontSize * 0.8)
                resizeFont(calculatedFont: calculatedFont)
                break
            case 812.0: //iphone X, XS => 5.8 inch
                calculatedFont = UIFont.systemFont(ofSize: standardFontSize * 0.9)
                resizeFont(calculatedFont: calculatedFont)
                break
            case 896.0: //iphone XR => 6.1 inch  // iphone XS MAX => 6.5 inch
                calculatedFont = UIFont.systemFont(ofSize: standardFontSize)
                resizeFont(calculatedFont: calculatedFont)
                break
            default:
                calculatedFont = UIFont.systemFont(ofSize: standardFontSize * 1.8)
                resizeFont(calculatedFont: calculatedFont)
                break
        }
    }

    func resizeFont(calculatedFont: UIFont?) {
        self.titleLabel?.font = calculatedFont
    }
}
