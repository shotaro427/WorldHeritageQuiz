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
    // 現在の問題番号を格納する変数
    var questionNumber: Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // =====================================================
    // 回答を確認する関数
    func checkAnswer(buttonNumber: Int) {
        
        // 回答があっているか確認
        if buttonNumber == answers[questionNumber - 1] {
            // アラートの表示
            showAlert(title: "正解です！", message: "次の問題に進みます。")
            
            switch questionNumber {
            case 1:
                // 問題1を隠す
                question1.isHidden = true
                
                
            case 2:
                // 問題2を隠す
                question2.isHidden = true
            case 3:
                // 問題3を隠す
                question3.isHidden = true
            default:
                break
            }
            
            // ボタンを１つ減らす
            hideButton()
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
    // ボタンアクション(ボタンのタグ情報から回答番号を取得 → 答え合わせをする関数に渡す)
    @IBAction func tappedAnswerButton(_ sender: UIButton) {
        // 回答の確認
        checkAnswer(buttonNumber: sender.tag)
    }
}

