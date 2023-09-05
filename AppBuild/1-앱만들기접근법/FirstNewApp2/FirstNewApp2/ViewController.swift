//
//  ViewController.swift
//  FirstNewApp2
//
//  Created by JuSun Kang on 2023/09/04.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var slider: UISlider!
    weak var timer: Timer?
    var number = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    func configureUI() {
        mainLabel.text = "초를 선택하세요"
        slider.value = 1
    }

    @IBAction func sliderChanged(_ sender: UISlider) {
        let seconds = Int(sender.value * 60)
        mainLabel.text = "\(seconds)초를 선택하세요"
        number = seconds
    }
    
    @IBAction func startButtonTapped(_ sender: UIButton) {
        // 1초가 지나갈 때마다 무언가를 실행
        timer?.invalidate()
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(doSomethingAfter1Second), userInfo: nil, repeats: true)
        
//        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { [self] _ in
            // 반복을 하고 싶은 코드
            
//            if number > 0 {
//                number -= 1
//                // 슬라이더도 줄여야됨
//                // 레이블표시도 다시 해줘야 됨
//                slider.value = Float(number) / Float(60)
//                mainLabel.text = "\(number)초를 선택하세요"
//            } else {
//                number = 0
//                mainLabel.text = "초를 선택하세요"
//
//                // 소리 필요
//                let systemSoundID: SystemSoundID = 1322
//                AudioServicesPlaySystemSound(systemSoundID)
//
//                // *타이머를 안죽이면 안됨*
//                timer?.invalidate()
//            }
//        })
    }
    
    @objc func doSomethingAfter1Second() {
        if number > 0 {
            number -= 1
            // 슬라이더도 줄여야됨
            // 레이블표시도 다시 해줘야 됨
            slider.value = Float(number) / Float(60)
            mainLabel.text = "\(number)초를 선택하세요"
        } else {
            number = 0
            mainLabel.text = "초를 선택하세요"
            
            // 소리 필요
            let systemSoundID: SystemSoundID = 1322
            AudioServicesPlaySystemSound(systemSoundID)
            
            // *타이머를 안죽이면 안됨*
            timer?.invalidate()
        }
    }
    
    @IBAction func resetButtonTapped(_ sender: UIButton) {
        mainLabel.text = "초를 선택하세요"
        slider.setValue(0.5, animated: true)
    }
    
}

