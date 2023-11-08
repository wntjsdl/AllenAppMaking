//
//  ControlViewController.swift
//  Chapter03-Alert
//
//  Created by JuSun Kang on 11/8/23.
//

import UIKit

class ControlViewController: UIViewController {
    
    private let slider = UISlider()
    
    var sliderValue: Float {
        return self.slider.value
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.slider.minimumValue = 0
        self.slider.maximumValue = 100
        
        self.slider.frame = CGRect(x: 0, y: 0, width: 170, height: 30)
        self.view.addSubview(slider)
        
        self.preferredContentSize = CGSize(width: self.slider.frame.width, height: self.slider.frame.height+10)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
