import UIKit
import RealmSwift

class HistoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITableViewDataSourcePrefetching {
    @IBOutlet weak var labelTime: UILabel!
    @IBOutlet weak var labelResult: UILabel!
    @IBOutlet weak var historyTableVeiw: UITableView!
    let realm = try! Realm()
    var DateArrary : Results<CalcHistory>?
    
    override func viewDidLoad() {
        loadData()
        super.viewDidLoad()
    }

    func loadData() {
        DateArrary = realm.objects(CalcHistory.self).sorted(byKeyPath: "date", ascending: true)
        self.historyTableVeiw.reloadData()
    }
    
}

extension HistoryViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let realm = try! Realm()
        let realmCount = realm.objects(CalcHistory.self).count
        return realmCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.historyTableVeiw!.dequeueReusableCell(withIdentifier: "HistoryTabelViewCell", for: indexPath) as! HistoryTableViewCell
        cell.labelCalc.text = DateArrary?[indexPath.row].result
        cell.labelDate.text = DateArrary?[indexPath.row].date
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        print("log prefetchRow \(IndexPath.self)")
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { _, _ in
            try? self.realm.write {
                self.realm.delete((self.DateArrary?[indexPath.row])!)
                self.historyTableVeiw.reloadData()
            }

        }
        deleteAction.backgroundColor = .red
        return [deleteAction]
    }
}
