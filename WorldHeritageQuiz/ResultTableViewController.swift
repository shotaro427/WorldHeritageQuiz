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
    // 総問題数
    var receiveQuestionsCount: Int = 0
    // 正解、不正解の配列
    var receiveResults: [Bool] = []
    
    // 問題1~3を入れる配列
    var questions: [String] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
        print(receiveQuestionsCount)
        print(receiveResults)
    }
    
    // セルの数
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return receiveQuestionsCount
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        

        return cell
    }
}
