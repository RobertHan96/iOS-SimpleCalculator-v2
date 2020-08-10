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

    func setupUI(){
        let buttons : [UIButton?] = [
            btnZero, btnOne, btnTwo, btnThree, btnFour ,btnFive, btnSix, btnSeven, btnEight, btnNine, btnRemainder, btnHistory, btnClear, btnMultiple,
            btnPlus, btnMinus, btnMultiple, btnEqual, btnPoint, btnDivision
        ]
        let model = UIDevice.current.model
        let deviceScrrenSize = UIScreen.main.bounds
        print("[Log] 디바이스 정보",model, deviceScrrenSize)

        let btnImageSize = btnHistory.bounds.height/4
        btnHistory.imageEdgeInsets = UIEdgeInsets(top: btnImageSize, left: btnImageSize, bottom: btnImageSize, right: btnImageSize)
        
        for button in buttons {
            if let btn = button {
                btn.setFontSizeDependOnScreenSize()
                btn.layer.cornerRadius = btn.bounds.width/4
                btn.titleLabel?.adjustsFontForContentSizeCategory = true
                btn.titleLabel?.adjustsFontSizeToFitWidth = true
            }
        }
        
    }
    
}


extension UIButton {
    func setFontSizeDependOnScreenSize() {
        let bounds = UIScreen.main.bounds
        let height = bounds.size.height
        let standardFontSize : CGFloat = 70
        var calculatedFont = UIFont.systemFont(ofSize: standardFontSize)
          switch height {
          case 480.0: //Iphone 3,4S => 3.5 inch
            calculatedFont = UIFont.systemFont(ofSize: 30)
            resizeFont(calculatedFont: calculatedFont)
            break
          case 568.0: //iphone 5, SE => 4 inch
            calculatedFont = UIFont.systemFont(ofSize: 30)
            resizeFont(calculatedFont: calculatedFont)
            break
          case 667.0: //iphone 6, 6s, 7, 8 => 4.7 inch
            calculatedFont = UIFont.systemFont(ofSize: 40)
            resizeFont(calculatedFont: calculatedFont)
            break
          case 736.0: //iphone 6s+ 6+, 7+, 8+ => 5.5 inch
            calculatedFont = UIFont.systemFont(ofSize: 50)
            resizeFont(calculatedFont: calculatedFont)
            break
          case 812.0: //iphone X, XS => 5.8 inch
            calculatedFont = UIFont.systemFont(ofSize: 70)
            resizeFont(calculatedFont: calculatedFont)
            break
          case 896.0: //iphone XR => 6.1 inch  // iphone XS MAX => 6.5 inch
            calculatedFont = UIFont.systemFont(ofSize: 70)
            resizeFont(calculatedFont: calculatedFont)
            break
          default:
            calculatedFont = UIFont.systemFont(ofSize: 100)
            resizeFont(calculatedFont: calculatedFont)
            break
          }
        }

    func resizeFont(calculatedFont: UIFont?) {
        self.titleLabel?.font = calculatedFont
    }

}
