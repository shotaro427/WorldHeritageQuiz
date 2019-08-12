//
//  ViewController.swift
//  WorldHeritageQuiz
//
//  Created by 田内　翔太郎 on 2019/08/12.
//  Copyright © 2019 田内　翔太郎. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // 問1~3までのview
    @IBOutlet weak var question1: UIView!
    @IBOutlet weak var question2: UIView!
    @IBOutlet weak var question3: UIView!
    
    // スタックビュー（回答ボタン）
    @IBOutlet weak var answersStackView: UIStackView!
    
    // 問題の答え
    let answers: [Int] = [1, 3, 2]
    // 現在の問題数を格納する変数
    var questionNumber: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // =====================================================
    // 回答を確認する関数
    func checkAnswer(buttonNumber: Int) {
        
        // 回答があっているか確認
        if buttonNumber == answers[questionNumber] {
            // アラートの表示
            showAlert(title: "正解です！", message: "次の問題に進みます。")
            // 問題番号を進める
            questionNumber += 1
        } else {
            showAlert(title: "不正解です...", message: "もう一度挑戦しますか？")
        }
    }
    
    // =====================================================
    // アラートを表示させる関数
    func showAlert(title: String?, message: String) {
        // アラートの作成
        let alert = UIAlertController(title: nil, message: message, preferredStyle:  .alert)
        // アラートのアクション（ボタン部分の定義）
        let close = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        // 作成したalertに閉じるボタンを追加
        alert.addAction(close)
        // アラートを表示する
        present(alert, animated: true, completion: nil)
    }
    
    // =====================================================
    // ボタンアクション(ボタンのタグ情報から回答番号を取得 → 答え合わせをする関数に渡す)
    @IBAction func tappedAnswerButton(_ sender: UIButton) {
        // 回答の確認
        checkAnswer(buttonNumber: sender.tag)
    }
}

