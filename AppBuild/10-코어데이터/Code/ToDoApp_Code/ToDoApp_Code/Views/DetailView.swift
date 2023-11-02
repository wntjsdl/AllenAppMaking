//
//  DetailView.swift
//  ToDoApp_Code
//
//  Created by JuSun Kang on 11/1/23.
//

import UIKit

final class DetailView: UIView {
    
    let redBtn: UIButton = {
        let button = UIButton()
        button.setTitle("Red", for: .normal)
        button.backgroundColor = .red
        return button
    }()
    
    let greenBtn: UIButton = {
        let button = UIButton()
        button.setTitle("Green", for: .normal)
        button.backgroundColor = .green
        return button
    }()
    
    let blueBtn: UIButton = {
        let button = UIButton()
        button.setTitle("Blue", for: .normal)
        button.backgroundColor = .blue
        return button
    }()
    
    let purpleBtn: UIButton = {
        let button = UIButton()
        button.setTitle("Purple", for: .normal)
        button.backgroundColor = .purple
        return button
    }()
    
    let stackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.distribution  = .fill
        sv.alignment = .fill
        sv.spacing = 15
        return sv
    }()
    
    func setupStackView() {
        // 스택뷰 위에 버튼 올리기
        stackView.addArrangedSubview(redBtn)
        stackView.addArrangedSubview(greenBtn)
        stackView.addArrangedSubview(blueBtn)
        stackView.addArrangedSubview(purpleBtn)
        
        // 뷰 컨트롤러 기본 뷰 위에 스택뷰 올리기
        self.addSubview(stackView)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupStackView()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }

}
