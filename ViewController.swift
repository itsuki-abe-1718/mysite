//
//  ViewController.swift
//  TestApp2
//
//  Created by 阿部樹 on 2021/02/17.
//説明：NHK番組表APIを使用し、タイトルと放送開始時間を画面に出力
//※取得したデータをprintで出力していますが、画面表示は未実装です。
//

import UIKit
import Alamofire

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
        
    @IBOutlet weak var programTableView: UITableView!
    
    //番組情報を格納
    var programArray: Array<String> = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return programArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel!.text = programArray[indexPath.row]
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Str to Date
        let df_2_date = DateFormatter()
        df_2_date.locale = Locale(identifier: "ja_JP")
        df_2_date.calendar = Calendar(identifier: .gregorian)
        df_2_date.dateFormat = "yyyy-MM-dd'T'HH:mm:ssXXX"

        // Date to Str
        let df_2_str = DateFormatter()
        df_2_str.dateFormat = "HH:mm"

        //Json取得・加工処理
        AF.request("https://api.nhk.or.jp/v2/pg/list/130/g1/2021-02-22.json?key=2ilVmC0TPX8K1uoWMcAMHmGHXcdGVEZm",method: .get,parameters: nil,encoding: JSONEncoding.default,headers: nil)
            .responseJSON { response in

                do {
                    let decoder: JSONDecoder = JSONDecoder()

                    let programs: Programlist = try decoder.decode(Programlist.self, from: response.data!)
                    print("debug OK")
                    
                    for program in programs.list.g1 {

                        let start_time_date = df_2_date.date(from: program.start_time)
                        let start_time_str = df_2_str.string(from: start_time_date!)
                        self.programArray.append(start_time_str + "：" + program.title)
                    }
                    print(self.programArray)
                    
                } catch {
                    print("failed")
                }
        }
    }
}

