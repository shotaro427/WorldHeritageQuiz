//
//  ViewController.swift
//  WorldHeritageQuiz
//
//  Created by 田内　翔太郎 on 2019/08/12.
//  Copyright © 2019 田内　翔太郎. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // 何問目かを表示する
    @IBOutlet weak var titleOfQuestion: UINavigationItem!
    // 問題を表示するtextView
    @IBOutlet weak var questionTextView: UITextView!
    // スタックビュー（回答ボタン）
    @IBOutlet weak var answersStackView: UIStackView!
    
    // 問題文
    let questions: [String] = [
        "問１日本の世界遺産『富士山－信仰の対象と芸術の源泉』は、2013年に（ ）として世界遺産登録されました。\n1. 文化遺産\n2. 自然遺産\n3. 山岳遺産\n4. 伝統遺産",
        "問2イタリア共和国の世界遺産『フィレンツェの歴史地区』のあるフィレンツェを中心に、17世紀に栄えた芸術運動は何でしょうか。\n1. シュルレアリスム\n2. アバンギャルド\n3. ルネサンス",
        "問3 2016年のオリンピック開催地であるリオ・デ・ジャネイロで、ブラジル独立100周年を記念して作られたキリスト像が立つ場所として、正しいものはどれか。\n1. コパカバーナの山\n2. コルコバードの丘"
    ]
    // 問題の答え
    let answers: [Int] = [1, 3, 2]
    
    // 結果を表示する画面に渡す情報群
    // 総問題数
    var questionsCount: Int = 0
    // 正解、不正解を判断する配列(true = 正解、false = 不正解)
    var correctOrIncorrect: [Bool] = []
    // 現在の問題番号を格納する変数
    var questionNumber: Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 総問題数を格納する
        questionsCount = questions.count
    }
    
    // 問題から結果の画面へ遷移したタイミングの処理
    override func viewWillDisappear(_ animated: Bool) {
        // タイトルの変更
        titleOfQuestion.title = "問題"
    }
    
    // 結果の画面から問題の画面に戻ってきた時の処理
    override func viewWillAppear(_ animated: Bool) {
        // navigationTitleを「1問目」に戻す
        titleOfQuestion.title = "\(questionNumber)番目"
    }
    
    // =====================================================
    // 回答を確認する関数
    func checkAnswer(playerAnswer: Int) {
        // 回答があっているか確認
        if playerAnswer == answers[questionNumber - 1] {
            if questionNumber != questions.count {
                // 配列に不正解(true)を入れる
                correctOrIncorrect.append(true)
                // アラートを表示
                showAlertWhenCorrect(title: "正解です！", message: "次の問題へ進みます。")
            } else {
                // 問題を出し終わった時の処理
                // 配列に不正解(true)を入れる
                correctOrIncorrect.append(true)
                // アラートを表示
                showAlertWhenCorrect(title: "正解です！", message: "結果を表示します。")
            }
        } else {
            // アラートを表示
            showAlertWhenIncorrect(title: "不正解です...", message: "もう一度挑戦しますか？")
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
            
            // 配列に不正解(false)を入れる
            self.correctOrIncorrect.append(false)
            // 次の問題へ
            self.nextQuestion()
        })
        // 作成したalertに閉じるボタンを追加
        alert.addAction(yes)
        alert.addAction(no)
        // アラートを表示する
        present(alert, animated: true, completion: nil)
    }
    
    // =====================================================
    // アラートを表示させる関数(正解時)
    func showAlertWhenCorrect(title: String?, message: String) {
        // アラートの作成
        let alert = UIAlertController(title: title, message: message, preferredStyle:  .alert)
        // アラートのアクション（ボタン部分の定義）
        let close = UIAlertAction(title: "OK", style: .default, handler: {(action: UIAlertAction!) in
            
            // 次の問題へ
            self.nextQuestion()
            
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
    func nextQuestion() {
        // questionNumberが問題数を超えないようにする
        if questionNumber < questions.count  {
            // ボタンを減らす
            hideButton()
            // 問題を次に進める
            questionNumber += 1
            // 次の問題を表示する
            questionTextView.text = questions[questionNumber - 1]
            // タイトルを変更する
            titleOfQuestion.title = "\(questionNumber)問目"
        } else {
            // 結果(tableView)に遷移
            performSegue(withIdentifier: "toResult", sender: nil)
            // 遷移後に問題状況をリセットする
            reset()
        }
    }
    
    // =====================================================
    // 遷移前に遷移先に情報を渡す関数
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // segueの識別子の確認
        if segue.identifier == "toResult" {
            // 次の画面を代入
            let nextVC = segue.destination as! ResultTableViewController
            // 値の受け渡し
            nextVC.receiveQuestionsCount = questionsCount
            nextVC.receiveResults = correctOrIncorrect
        }
    }
    
    // =====================================================
    // 問題の状況をリセットする関数
    func reset() {
        // 問題を初めからにする
        questionTextView.text = questions[0]
        // ボタンを見えるようにする
        for button in answersStackView.arrangedSubviews {
            button.isHidden = false
        }
        // 問題番号を初めからにする
        questionNumber = 1
        // 正解、不正解を入れる配列を初期化する
        correctOrIncorrect = []
    }
    
    // =====================================================
    // ボタンアクション(ボタンのタグ情報から回答番号を取得 → 答え合わせをする関数に渡す)
    @IBAction func tappedAnswerButton(_ sender: UIButton) {
        // 回答の確認
        checkAnswer(playerAnswer: sender.tag)
    }
}

