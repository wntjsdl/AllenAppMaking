//
//  ViewController.swift
//  MyToDoApp
//
//  Created by Allen H on 2022/04/21.
//

import UIKit

final class ViewController: UIViewController {

    // 테이블뷰 생성 (테이블뷰와 셀이 뷰라고 보면 되기 때문에 굳이 detail뷰 또 안 만들어도됨) ⭐️
    private let tableView = UITableView()
    
    // 모델(저장 데이터를 관리하는 코어데이터)
    let toDoManager = CoreDataManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNaviBar()
        setupTableView()
        setupTableViewConstraints()
    }
    
    // 화면에 다시 진입할때마다 다시 테이블뷰 그리기 (업데이트 등 제대로 표시)
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
        tableView.reloadData()
    }
    
    // 네이게이션바 설정
    func setupNaviBar() {
        self.title = "메모"
        
        // (네비게이션바 설정관련) iOS버전 업데이트 되면서 바뀐 설정
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()  // 불투명으로
        appearance.backgroundColor = .white
        navigationController?.navigationBar.tintColor = .systemBlue
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.prefersLargeTitles = true
        
        // 네비게이션바 우측에 Plus 버튼 만들기
        let plusButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(plusButtonTapped))
        plusButton.tintColor = .black
        navigationItem.rightBarButtonItem = plusButton
    }

    func setupTableView() {
        tableView.dataSource = self
        tableView.separatorStyle = .none
        
        // 셀의 등록과정 ⭐️ (코드로 구현)
        tableView.register(ToDoCell.self, forCellReuseIdentifier: "ToDoCell")
    }
    
    // 테이블뷰 자체의 오토레이아웃
    func setupTableViewConstraints() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
    }
    
    // 네비바 상단 플러스 버튼 눌렸을때
    @objc func plusButtonTapped() {
        let detailVC = DetailViewController()
        
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoManager.getToDoListFromCoreData().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCell", for: indexPath) as! ToDoCell
        
        // (테이블뷰 그리기 위한) 셀에 모델(ToDoData) 전달
        let toDoData = toDoManager.getToDoListFromCoreData()
        cell.toDoData = toDoData[indexPath.row]
        
        
        // 셀위에 있는 버튼이 눌렸을때 (뷰컨트롤러에서) 어떤 행동을 하기 위해서 클로저 전달 ⭐️
        // 세그웨이 대신 직접 push
        cell.updateButtonPressed = { [weak self] (senderCell) in
            let detailVC = DetailViewController()
            let selectedToDo = self?.toDoManager.getToDoListFromCoreData()[indexPath.row]
            detailVC.toDoData = selectedToDo
            
            self?.navigationController?.pushViewController(detailVC, animated: true)
        }
        
        cell.selectionStyle = .none
        return cell
    }
}

// 셀 위에 UPDATE 버튼을 눌러서 이동하기 때문에 델리게이트 이동은 필요 없음 ⭐️
//extension ViewController: UITableViewDelegate {
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let detailVC = DetailViewController()
//        let selectedToDo = toDoManager.getToDoListFromCoreData()[indexPath.row]
//        detailVC.toDoData = selectedToDo
//
//        navigationController?.pushViewController(detailVC, animated: true)
//    }
//}
