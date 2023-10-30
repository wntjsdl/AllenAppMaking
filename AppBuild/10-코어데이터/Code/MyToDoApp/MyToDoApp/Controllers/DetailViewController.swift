//
//  DetailViewController.swift
//  MyToDoApp
//
//  Created by Allen H on 2022/04/21.
//

import UIKit

final class DetailViewController: UIViewController {
    
    private let detailView = DetailView()
    
    override func loadView() {
        self.view = detailView
    }
    
    // 모델(저장 데이터를 관리하는 코어데이터)
    let toDoManager = CoreDataManager.shared
    
    var toDoData: ToDoData? {
        didSet {
            temporaryNum = toDoData?.color
        }
    }
    
    // ToDo 색깔 구분을 위해 임시적으로 숫자저장하는 변수
    // (나중에 어떤 색상이 선택되어 있는지 쉽게 파악하기 위해)
    var temporaryNum: Int64? = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        configureUI()
    }
    
    func setup() {
        detailView.mainTextView.delegate = self
        detailView.buttons.forEach { button in
            button.addTarget(self, action: #selector(colorButtonTapped), for: .touchUpInside)
        }
        clearButtonColors()
        navigationController?.navigationBar.prefersLargeTitles = false
        
        detailView.saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
    }
    
    func configureUI() {
        // 기존데이터가 있을때
        if let toDoData = self.toDoData {
            self.title = "메모 수정하기"
            
            guard let text = toDoData.memoText else { return }
            detailView.mainTextView.text = text
            
            detailView.mainTextView.textColor = .black
            detailView.saveButton.setTitle("UPDATE", for: .normal)
            detailView.mainTextView.becomeFirstResponder()
            let color = MyColor(rawValue: toDoData.color)
            setupColorTheme(color: color)
            
        // 기존데이터가 없을때
        } else {
            self.title = "새로운 메모 생성하기"
            
            detailView.mainTextView.text = "텍스트를 여기에 입력하세요."
            detailView.mainTextView.textColor = .lightGray
            setupColorTheme(color: .red)
        }
        setupColorButton(num: temporaryNum ?? 1)
    }

    
    @objc func colorButtonTapped(_ sender: UIButton) {
        // 임시숫자 저장
        self.temporaryNum = Int64(sender.tag)
        
        let color = MyColor(rawValue: Int64(sender.tag))
        setupColorTheme(color: color)
        
        clearButtonColors()
        setupColorButton(num: Int64(sender.tag))
    }
    
    // 텍스트뷰/저장(업데이트)버튼 색상 설정
    func setupColorTheme(color: MyColor? = .red) {
        detailView.backgroundView.backgroundColor = color?.backgoundColor
        detailView.saveButton.backgroundColor = color?.buttonColor
    }
    
    // 버튼 색상 새롭게 셋팅
    func clearButtonColors() {
        detailView.redButton.backgroundColor = MyColor.red.backgoundColor
        detailView.redButton.setTitleColor(MyColor.red.buttonColor, for: .normal)
        detailView.greenButton.backgroundColor = MyColor.green.backgoundColor
        detailView.greenButton.setTitleColor(MyColor.green.buttonColor, for: .normal)
        detailView.blueButton.backgroundColor = MyColor.blue.backgoundColor
        detailView.blueButton.setTitleColor(MyColor.blue.buttonColor, for: .normal)
        detailView.purpleButton.backgroundColor = MyColor.purple.backgoundColor
        detailView.purpleButton.setTitleColor(MyColor.purple.buttonColor, for: .normal)
    }
    
    // 눌려진 버튼 색상 설정
    func setupColorButton(num: Int64) {
        switch num {
        case 1:
            detailView.redButton.backgroundColor = MyColor.red.buttonColor
            detailView.redButton.setTitleColor(.white, for: .normal)
        case 2:
            detailView.greenButton.backgroundColor = MyColor.green.buttonColor
            detailView.greenButton.setTitleColor(.white, for: .normal)
        case 3:
            detailView.blueButton.backgroundColor = MyColor.blue.buttonColor
            detailView.blueButton.setTitleColor(.white, for: .normal)
        case 4:
            detailView.purpleButton.backgroundColor = MyColor.purple.buttonColor
            detailView.purpleButton.setTitleColor(.white, for: .normal)
        default:
            detailView.redButton.backgroundColor = MyColor.red.buttonColor
            detailView.redButton.setTitleColor(.white, for: .normal)
        }
    }
    
    @objc func saveButtonTapped(_ sender: UIButton) {
        // 기존데이터가 있을때 ===> 기존 데이터 업데이트
        if let toDoData = self.toDoData {
            // 텍스트뷰에 저장되어 있는 메세지
            toDoData.memoText = detailView.mainTextView.text
            toDoData.color = temporaryNum ?? 1
            toDoManager.updateToDo(newToDoData: toDoData) {
                print("업데이트 완료")
                // 다시 전화면으로 돌아가기
                self.navigationController?.popViewController(animated: true)
            }
            
        // 기존데이터가 없을때 ===> 새로운 데이터 생성
        } else {
            let memoText = detailView.mainTextView.text
            toDoManager.saveToDoData(toDoText: memoText, colorInt: temporaryNum ?? 1) {
                print("저장완료")
                // 다시 전화면으로 돌아가기
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    // 다른 곳을 터치하면 키보드 내리기
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

extension DetailViewController: UITextViewDelegate {
    // 입력을 시작할때
    // (텍스트뷰는 플레이스홀더가 따로 있지 않아서, 플레이스 홀더처럼 동작하도록 직접 구현)
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "텍스트를 여기에 입력하세요." {
            textView.text = nil
            textView.textColor = .black
        }
    }
    
    // 입력이 끝났을때
    func textViewDidEndEditing(_ textView: UITextView) {
        // 비어있으면 다시 플레이스 홀더처럼 입력하기 위해서 조건 확인
        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            textView.text = "텍스트를 여기에 입력하세요."
            textView.textColor = .lightGray
        }
    }
}

