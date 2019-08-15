//
//  ResultTableViewController.swift
//  WorldHeritageQuiz
//
//  Created by 田内　翔太郎 on 2019/08/12.
//  Copyright © 2019 田内　翔太郎. All rights reserved.
//

import UIKit

class ResultTableViewController: UITableViewController {
    
    // 遷移元から受け取る情報
    // 正解、不正解の配列
    var receiveResults: [Bool] = []

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // セルの数
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 総問題数分のセルを表示
        return receiveResults.count
    }

    // セルの操作
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        // trueなら丸をfalseならバツをつける
        if receiveResults[indexPath.row] {
            cell.textLabel?.text = "問題\(indexPath.row + 1)⭕️"
        } else {
            cell.textLabel?.text = "問題\(indexPath.row + 1)❌"
        }
        return cell
    }
}
