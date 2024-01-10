//
//  MemberListViewModel.swift
//  MemberList
//
//  Created by JuSun Kang on 1/9/24.
//

import UIKit

class MemberListViewModel {
    
    var dataManager: MemberListManager
    
    let title: String
    
    private var memberList: [Member] {
        return dataManager.getMembersList()
    }
    
    init(dataManager: MemberListManager, title: String) {
        self.dataManager = dataManager
        self.title = title
    }
    
    // MARK: - Output
    
    var numberOfSections: Int {
        return 1
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        return self.memberList.count
    }
    
    // 단일 뷰모델 생성
    func memberViewModelAtIndex(_ index: Int) -> MemberViewModel {
        let member = self.memberList[index]
        return MemberViewModel(dataManager: self.dataManager, member: member, index: index)
    }
    
    
    // MARK: - Input
    
    func makeNewMember(_ member: Member) {
        dataManager.makeNewMember(member)
    }
    
    func updateMemberInfo(index: Int, with member: Member) {
        dataManager.updateMemberInfo(index: index, with: member)
    }
    
    
    // MARK: - Logic
    
    func moveNextVCFromCurrentVC(_ index: Int? = nil, currentVC: UIViewController, animated: Bool) {
        if let index = index {
            let memberVM = memberViewModelAtIndex(index)
            goToNextVC(with: memberVM, fromCurrentVC: currentVC, animated: animated)
        } else {
            let newVM = MemberViewModel(dataManager: self.dataManager, member: nil, index: nil)
            goToNextVC(with: newVM, fromCurrentVC: currentVC, animated: animated)
        }
    }
    
    private func goToNextVC(with memberVM: MemberViewModel, fromCurrentVC: UIViewController, animated: Bool) {
        
        let navVC = fromCurrentVC.navigationController
        
        let detailVC = DetailViewController(viewModel: memberVM)
        navVC?.pushViewController(detailVC, animated: animated)
    }
    
}
