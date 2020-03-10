//
//  ViewController.swift
//  CclculatorApp_test
//
//  Created by 小野瞭 on 2020/03/10.
//  Copyright © 2020 akira.ono. All rights reserved.
//

import UIKit
import Expression

class ViewController: UIViewController {
    @IBAction func calculateAnswer(_ sender: UIButton) {
        //ボタン=が押されたら計算式と計算結果を表示する
        guard let formuraText = formuralabel.text else {
            return
        }
        let formula:String = formatFormula(formuraText)
        answerlabel.text = evalFormula(formula)
    }
    
    private func formatFormula(_ formula:String) -> String {
        //入力された文字列を置換して解釈
        let formattedFormula: String = formula .replacingOccurrences(of: "(?<=^|[÷×\\+\\-\\(])([0-9]+)(?=[÷×\\+\\-\\)]|$)", with: "$1.0", options: NSString.CompareOptions.regularExpression, range: nil).replacingOccurrences(of: "÷", with: "/").replacingOccurrences(of: "×", with: "*")
        return formattedFormula
    }
    
    private func evalFormula(_ formula:String) -> String{
        do{
            let expression = Expression(formula)
            let answer = try expression.evaluate()
            return formatAnswer(String(answer))
        } catch {
            // 計算式が不当だった場合
            return "式を正しく入力してください"
        }
    }
    
    
    private func formatAnswer(_ answer: String) -> String {
        // 答えの小数点以下が`.0`だった場合は、`.0`を削除して答えを整数で表示する
        let formattedAnswer: String = answer.replacingOccurrences(
                of: "\\.0$",
                with: "",
                options: NSString.CompareOptions.regularExpression,
                range: nil)
        return formattedAnswer
    }
    
    
    
    @IBAction func clearCalculation(_ sender: UIButton) {
        //ボタンCが入力されたらテキストボックスを消す
        formuralabel.text = ""
        answerlabel.text = ""
    }
    
    @IBAction func imputFormula(_ sender: UIButton) {
        //Cと=以外のボタンが押された時の処理
        //guardはOptional型の変数がnilでない場合は実行, nilならelseを実行するガード
        guard let formuraText = formuralabel.text else {
            return
        }
        guard let senderedText = sender.titleLabel?.text else {
            return
        }
        formuralabel.text = formuraText + senderedText
    }
    
    @IBOutlet weak var answerlabel: UILabel!
    @IBOutlet weak var formuralabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //ロードの時点で計算式と答えのテキストを空にする
        formuralabel.text = ""
        answerlabel.text = ""
        
    }


}

