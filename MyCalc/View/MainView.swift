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
    @IBOutlet weak var btnDivision: UILabel!

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
        btnZero.layer.cornerRadius = btnZero.bounds.width/4
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
        btnEqual.layer.cornerRadius = btnEqual.bounds.width/4
        btnPoint.layer.cornerRadius = btnPoint.bounds.width/4
    }
    
}
