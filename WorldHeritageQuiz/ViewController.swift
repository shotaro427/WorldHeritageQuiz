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
    @IBOutlet var questions: [UIView]!
    
    
    // スタックビュー（回答ボタン）
    @IBOutlet weak var answersStackView: UIStackView!
    
    // 問題の答え
    let answers: [Int] = [1, 3, 2]
    // 現在の問題番号を格納する変数
    var questionNumber: Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // =====================================================
    // 回答を確認する関数
    func checkAnswer(playerAnswer: Int) {
        
        if questionNumber < answers.count {
            // 回答があっているか確認
            if playerAnswer == answers[questionNumber - 1] {
                
                showAlertWhenCorrect(title: "正解です！", message: "次の問題へ進みます。")
                
            } else {
                showAlertWhenIncorrect(title: "不正解です...", message: "もう一度挑戦しますか？")
            }
        } else {
            // 結果(tableView)の画面へ遷移
            performSegue(withIdentifier: "toResult", sender: nil)
        }
    }
    
    // =====================================================
    // アラートを表示させる関数(不正解時)
    func showAlertWhenIncorrect(title: String?, message: String) {
        // アラートの作成
        let alert = UIAlertController(title: title, message: message, preferredStyle:  .alert)
        // アラートのアクション（もう一度の場合）
        let yes = UIAlertAction(title: "はい", style: .default, handler: nil)
        // アラートのアクション（もう一度の場合）
        let no = UIAlertAction(title: "いいえ", style: .default, handler: {(action: UIAlertAction!) in
            
            // viewを隠す
            self.questions[self.questionNumber - 1].isHidden = true
            // ボタンを１つ減らす
            self.hideButton()
            // 問題番号を進める
            self.questionNumber += 1
            
        })
        // 作成したalertに閉じるボタンを追加
        alert.addAction(yes)
        alert.addAction(no)
        // アラートを表示する
        present(alert, animated: true, completion: nil)
    }
    
    // アラートを表示させる関数(正解時)
    func showAlertWhenCorrect(title: String?, message: String) {
        // アラートの作成
        let alert = UIAlertController(title: title, message: message, preferredStyle:  .alert)
        // アラートのアクション（ボタン部分の定義）
        let close = UIAlertAction(title: "OK", style: .default, handler: {(action: UIAlertAction!) in
            
            // viewを隠す
            self.questions[self.questionNumber - 1].isHidden = true
            // ボタンを１つ減らす
            self.hideButton()
            // 問題番号を進める
            self.questionNumber += 1
            
        })
        // 作成したalertに閉じるボタンを追加
        alert.addAction(close)
        // アラートを表示する
        present(alert, animated: true, completion: nil)
    }
    
    // =====================================================
    // ボタンを1つ減らす処理
    func hideButton() {
        // スタックビュー内のボタンの数を取得
        let sumOfButton: Int = answersStackView.arrangedSubviews.count
        // どのボタンを消すかを決める
        let hideButtonNumber: Int = sumOfButton - questionNumber
        // {(スタックビューの要素数) - (問題番号)}番目のボタンを隠す
        answersStackView.arrangedSubviews[hideButtonNumber].isHidden = true
    }
    
    // =====================================================
    //問題を１つ進める関数
    
    
    // =====================================================
    // ボタンアクション(ボタンのタグ情報から回答番号を取得 → 答え合わせをする関数に渡す)
    @IBAction func tappedAnswerButton(_ sender: UIButton) {
        // 回答の確認
        checkAnswer(playerAnswer: sender.tag)
    }
}

