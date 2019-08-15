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
    
    /// 問題文
    let questions: [String] = [
        "問１日本の世界遺産『富士山－信仰の対象と芸術の源泉』は、2013年に（ ）として世界遺産登録されました。\n1. 文化遺産\n2. 自然遺産\n3. 山岳遺産\n4. 伝統遺産",
        "問2イタリア共和国の世界遺産『フィレンツェの歴史地区』のあるフィレンツェを中心に、17世紀に栄えた芸術運動は何でしょうか。\n1. シュルレアリスム\n2. アバンギャルド\n3. ルネサンス",
        "問3 2016年のオリンピック開催地であるリオ・デ・ジャネイロで、ブラジル独立100周年を記念して作られたキリスト像が立つ場所として、正しいものはどれか。\n1. コパカバーナの山\n2. コルコバードの丘"
    ]
    /// 問題の答え
    let answers: [Int] = [1, 3, 2]
    /// 現在の問題番号を格納する変数
    var questionNumber: Int = 1
    
    // 結果を表示する画面(tableView)に渡す情報
    /// 正解、不正解を判断する配列(true = 正解、false = 不正解)
    var correctOrIncorrect: [Bool] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    /**
     * 回答を確認して、表示させるアラートを決定する関数
     * - Parameters:
     *   - playerAnswer: プレイヤーの回答番号
     */
    func checkAnswer(playerAnswer: Int) {
        // 回答があっているか確認
        if playerAnswer == answers[questionNumber - 1] { //正解時
            if questionNumber < questions.count {
                // アラートを表示
                showAlertWhenCorrect(title: "正解です！", message: "次の問題へ進みます。")
            } else {
                // 最後の問題の時の処理
                // アラートを表示
                showAlertWhenCorrect(title: "正解です！", message: "結果を表示します。")
            }
        } else { // 不正解時
            // アラートを表示
            showAlertWhenIncorrect(title: "不正解です...", message: "もう一度挑戦しますか？")
        }
    }
    
    // =====================================================
    /**
     * 不正解時用のアラートを表示させる関数
     * - Parameters:
     *   - title: アラートに表示するタイトル
     *   - message: アラートに表示させるメッセージ
     */
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
        // 作成したalertにボタンを追加
        alert.addAction(yes)
        alert.addAction(no)
        // アラートを表示する
        present(alert, animated: true, completion: nil)
    }
    
    // =====================================================
    /**
     * 正解時用のアラートを表示させる関数
     * - Parameters:
     *   - title: アラートに表示するタイトル
     *   - message: アラートに表示させるメッセージ
     */
    func showAlertWhenCorrect(title: String?, message: String) {
        // アラートの作成
        let alert = UIAlertController(title: title, message: message, preferredStyle:  .alert)
        // アラートのアクション（ボタン部分の定義）
        let close = UIAlertAction(title: "OK", style: .default, handler: {(action: UIAlertAction!) in
            // 配列に正解(true)を入れる
            self.correctOrIncorrect.append(true)
            // 次の問題へ
            self.nextQuestion()
        })
        // 作成したalertにボタンを追加
        alert.addAction(close)
        // アラートを表示する
        present(alert, animated: true, completion: nil)
    }
    
    // =====================================================
    /// ボタンを1つ減らす処理
    func hideButton() {
        /// どのボタンを消すかを決める
        /// * ボタンの総数　ー　問題番号
        let hideButtonNumber: Int = answersStackView.arrangedSubviews.count - questionNumber
        // {(スタックビューの要素数) - (問題番号)}番目のボタンを隠す
        answersStackView.arrangedSubviews[hideButtonNumber].isHidden = true
    }
    
    // =====================================================
    /// 問題を１つ進める関数
    func nextQuestion() {
        // questionNumberが問題数を超えないようにする
        if questionNumber < questions.count  {
            // ボタンを減らす
            hideButton()
            // 問題番号を次に進める
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
    /// 遷移前に遷移先に情報を渡す関数
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // segueの識別子の確認
        if segue.identifier == "toResult" {
            // 次の画面を代入
            let nextVC = segue.destination as! ResultTableViewController
            // 値の受け渡し
            nextVC.receiveResults = correctOrIncorrect
        }
    }
    
    // =====================================================
    /// 問題の状況をリセットする関数
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
    /// ボタンアクション(ボタンのタグ情報から回答番号を取得 → 答え合わせをする関数に渡す)
    @IBAction func tappedAnswerButton(_ sender: UIButton) {
        // 回答の確認
        checkAnswer(playerAnswer: sender.tag)
    }
}

