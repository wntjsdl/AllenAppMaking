//
//  ViewController.swift
//  MyFirstApp
//
//  Created by Allen H on 2021/05/15.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var myButton: UIButton!
    

    // 해당 앱 화면에 진입했을때 가장 먼저 자동으로 실행되는 함수
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        mainLabel.backgroundColor = UIColor.yellow
//        view.backgroundColor = UIColor.yellow
    }

    
    @IBAction func buttonPressed(_ sender: UIButton) {
        
//        mainLabel.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        mainLabel.text = "안녕하세요"
        
        myButton.backgroundColor = UIColor.yellow
        myButton.setTitleColor(.black, for: .normal)
//        mainLabel.backgroundColor = UIColor.yellow
        
//        mainLabel.textColor = #colorLiteral(red: 0.5791940689, green: 0.1280144453, blue: 0.5726861358, alpha: 1)
//        mainLabel.textAlignment = NSTextAlignment.right
    }
    
    
    

}

