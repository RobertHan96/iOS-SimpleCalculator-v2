
import UIKit
import RealmSwift


class HistoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var labelTime: UILabel!
    @IBOutlet weak var labelResult: UILabel!
    @IBOutlet weak var MyTableView: UITableView!
    
    let realm = try! Realm()
    var DateArrary : Results<CalcHistory>?
    
    func loadData() {
        DateArrary = realm.objects(CalcHistory.self).sorted(byKeyPath: "date", ascending: true)
        self.MyTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let realm = try! Realm()
        let realmCount = realm.objects(CalcHistory.self).count
        return realmCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.MyTableView!.dequeueReusableCell(withIdentifier: "HistoryTabelViewCell", for: indexPath) as! HistoryTableViewCell
        cell.labelCalc.text = DateArrary?[indexPath.row].result
        cell.labelDate.text = DateArrary?[indexPath.row].date
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    
    override func viewDidLoad() {
        loadData()
        super.viewDidLoad()
    }
}
