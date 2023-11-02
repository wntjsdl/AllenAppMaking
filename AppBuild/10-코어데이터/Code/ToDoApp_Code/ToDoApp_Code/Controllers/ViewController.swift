//
//  ViewController.swift
//  ToDoApp_Code
//
//  Created by JuSun Kang on 10/30/23.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    private let tableView = UITableView()
    
    // 모델(저장 데이터를 관리하는 코어데이터)
    let toDoManager = CoreDataManager.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setupConstraints()
    }
    
    func configureUI() {
        navigationController?.navigationBar.prefersLargeTitles = true
        self.title = "메모"
        
        // 네비게이션바 우측에 Plus 버튼 만들기
        let plusButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(plusButtonTapped))
        plusButton.tintColor = .black
        navigationItem.rightBarButtonItem = plusButton
    }
    
    func setupConstraints() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.bottom.equalTo(view.snp.bottom)
            make.top.equalTo(view.snp.top)
            make.leading.equalTo(view.snp.leading)
            make.trailing.equalTo(view.snp.trailing)
        }
    }
    
    @objc func plusButtonTapped() {
        print("추가 버튼")
//        performSegue(withIdentifier: "ToDoCell", sender: nil)
    }


}

//extension ViewController: UITableViewDataSource {
    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return toDoManager.getToDoListFromCoreData().count
//    }
    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCell", for: indexPath) as! ToDoCell
//        // 셀에 모델(ToDoData) 전달
//        let toDoData = toDoManager.getToDoListFromCoreData()
//        cell.toDoData = toDoData[indexPath.row]
//        
//        // 셀위에 있는 버튼이 눌렸을때 (뷰컨트롤러에서) 어떤 행동을 하기 위해서 클로저 전달
//        cell.updateButtonPressed = { [weak self] (senderCell) in
//            // 뷰컨트롤러에 있는 세그웨이의 실행
//            self?.performSegue(withIdentifier: "ToDoCell", sender: indexPath)
//        }
//        
//        cell.selectionStyle = .none
//        return cell
//    }
    
//}

extension ViewController: UITableViewDelegate {
    
    // (세그웨이를 실행할때) 실제 데이터 전달 (ToDoData전달)
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "ToDoCell" {
//            let detailVC = segue.destination as! DetailViewController
//            
//            guard let indexPath = sender as? IndexPath else { return }
//            detailVC.toDoData = toDoManager.getToDoListFromCoreData()[indexPath.row]
//        }
//    }
    
    // 테이블뷰의 높이를 자동적으로 추청하도록 하는 메서드
    // (ToDo에서 메세지가 길때는 셀의 높이를 더 높게 ==> 셀의 오토레이아웃 설정도 필요)
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
