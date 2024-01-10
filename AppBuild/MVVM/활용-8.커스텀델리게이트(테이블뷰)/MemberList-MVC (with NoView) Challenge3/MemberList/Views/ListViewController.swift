//
//  ViewController.swift
//  MemberList
//
//  Created by Allen H on 2022/02/04.
//

import UIKit

final class ListViewController: UIViewController {

    private let tableView = UITableView()
    
    //MARK: - 관리 모델 선언
//    var dataManager: MemberListManager
    
    let viewModel: MemberListViewModel
    
    lazy var plusButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(plusButtonTapped))
        return button
    }()
    
    init(viewModel: MemberListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - 라이프사이클
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        setupNaviBar()
        setupTableView()
        setupTableViewConstraints()
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        tableView.reloadData()
//    }
    
    func setupNaviBar() {
        title = viewModel.title
    
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        
        navigationController?.navigationBar.tintColor = .systemBlue
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        self.navigationItem.rightBarButtonItem = self.plusButton
    }

    
    //MARK: - 테이블뷰 셋팅
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 60
        tableView.register(MyTableViewCell.self, forCellReuseIdentifier: "MemberCell")
    }
    
    
    //MARK: - 오토레이아웃 셋팅
    
    func setupTableViewConstraints() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ])
    }
    
    @objc func plusButtonTapped() {
//        let detailVC = DetailViewController()
//        detailVC.delegate = self
//        navigationController?.pushViewController(detailVC, animated: true)
        
        viewModel.moveNextVCFromCurrentVC(currentVC: self, animated: true)
    }
    
}

//MARK: - 테이블뷰 데이터 소스 구현
extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemberCell", for: indexPath) as! MyTableViewCell
//        cell.member = memberListManager[indexPath.row]
        
        let memberVM = viewModel.memberViewModelAtIndex(indexPath.row)
        cell.viewModel = memberVM
        
        cell.selectionStyle = .none
        return cell
    }
}

//MARK: - 테이블뷰 델리게이트 구현 (셀이 선택되었을때)

extension ListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let detailVC = DetailViewController()
//        detailVC.delegate = self
//        
//        let currentMember = memberListManager.getMembersList()[indexPath.row]
//        detailVC.member = currentMember
//        
//        navigationController?.pushViewController(detailVC, animated: true)
        viewModel.moveNextVCFromCurrentVC(indexPath.row, currentVC: self, animated: true)
    }
}

//MARK: - 멤버 추가하거나, 업데이트에 대한 델리게이트 구현

//extension ListViewController: MemberDelegate {
//
//    func addNewMember(with member: Member) {
////        memberListManager.makeNewMember(member)
//        viewModel.makeNewMember(member)
//        tableView.reloadData()
//    }
//    
//    func updateMember(at index: Int, with member: Member) {
////        memberListManager.updateMemberInfo(index: index, with: member)
//        viewModel.updateMemberInfo(index: index, with: member)
//        tableView.reloadData()
//    }
//    
//}
