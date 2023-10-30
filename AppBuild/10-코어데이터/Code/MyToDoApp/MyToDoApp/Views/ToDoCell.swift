//
//  ToDoCell.swift
//  MyToDoApp
//
//  Created by Allen H on 2022/04/21.
//

import UIKit

final class ToDoCell: UITableViewCell {
    
    let backView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let toDoTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let basicView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var stackView: UIStackView = {
        let stview = UIStackView(arrangedSubviews: [toDoTextLabel, basicView])
        stview.spacing = 10
        stview.axis = .vertical
        stview.distribution = .fill
        stview.alignment = .fill
        stview.translatesAutoresizingMaskIntoConstraints = false
        return stview
    }()
    
    let dateTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var updateButton: UIButton = {
        let button = UIButton(type: .custom)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 9)
        button.setImage(UIImage(systemName: "pencil.tip"), for: .normal)
        button.setTitle("UPDATE", for: .normal)
        button.tintColor = .white
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(updateButtonTapped), for: .touchUpInside)
        return button
    }()
    
    // ToDoData를 전달받을 변수 (전달 받으면 ==> 표시하는 메서드 실행) ⭐️
    var toDoData: ToDoData? {
        didSet {
            configureUIwithData()
        }
    }
    
    // (델리게이트 대신에) 실행하고 싶은 클로저 저장
    // 뷰컨트롤러에 있는 클로저 저장할 예정 (셀(자신)을 전달)
    var updateButtonPressed: (ToDoCell) -> Void = { (sender) in }

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        
        // 셀 오토레이아웃 일반적으로 생성자에서 잡으면 됨 ⭐️
        setConstraints()
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 오토레이아웃 코드
    func setConstraints() {
        self.contentView.addSubview(backView)
        
        NSLayoutConstraint.activate([
            backView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 25),
            backView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -25),
            backView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10),
            backView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -10)
        ])
        
        self.contentView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: self.backView.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: self.backView.trailingAnchor, constant: -10),
            stackView.topAnchor.constraint(equalTo: self.backView.topAnchor, constant: 10),
            stackView.bottomAnchor.constraint(equalTo: self.backView.bottomAnchor, constant: -10)
        ])
        
        NSLayoutConstraint.activate([
            toDoTextLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 50)
        ])
        
        
        self.basicView.addSubview(dateTextLabel)
        self.basicView.addSubview(updateButton)
        
        NSLayoutConstraint.activate([
            basicView.heightAnchor.constraint(equalToConstant: 30),
            
            dateTextLabel.leadingAnchor.constraint(equalTo: self.basicView.leadingAnchor, constant: 0),
            dateTextLabel.bottomAnchor.constraint(equalTo: self.basicView.bottomAnchor, constant: 0),
            
            updateButton.widthAnchor.constraint(equalToConstant: 70),
            updateButton.heightAnchor.constraint(equalToConstant: 26),
            updateButton.trailingAnchor.constraint(equalTo: self.basicView.trailingAnchor, constant: 0),
            updateButton.bottomAnchor.constraint(equalTo: self.basicView.bottomAnchor, constant: 0)
        ])
        
        toDoTextLabel.setContentCompressionResistancePriority(.init(rawValue: 752), for: .horizontal)
        
    }
    
    // 기본 UI 설정
    func configureUI() {
        backView.clipsToBounds = true
        backView.layer.cornerRadius = 8
        
        updateButton.clipsToBounds = true
        updateButton.layer.cornerRadius = 10
    }
    
    // (투두) 데이터를 가지고 적절한 UI 표시하기
    func configureUIwithData() {
        toDoTextLabel.text = toDoData?.memoText
        dateTextLabel.text = toDoData?.dateString
        guard let colorNum = toDoData?.color else { return }
        let color = MyColor(rawValue: colorNum) ?? .red
        updateButton.backgroundColor = color.buttonColor
        backView.backgroundColor = color.backgoundColor
    }

    // 버튼이 눌리면 updateButtonPressed변수에 들어있는 클로저 실행⭐️
    @objc func updateButtonTapped(_ sender: UIButton) {
        updateButtonPressed(self)
    }
}
