//
//  MemberListViewModel.swift
//  MemberList
//
//  Created by JuSun Kang on 1/8/24.
//

import UIKit

class MemberListViewModel {
    
    //MARK: - 관리 모델 선언
    let dataManager: MemberListType
    
    let title: String
    
    private var memberList: [Member] {
        return dataManager.getMembersList()
    }
    
    init(dataManager: MemberListType, title: String) {
        self.dataManager = dataManager
        self.title = title
    }
    
    
    // Output
    var numberOfSections: Int {
        return 1
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        return self.memberList.count
    }
    
    func memberViewModelAtIndex(_ index: Int) -> MemberViewModel {
        let member = self.memberList[index]
        return MemberViewModel(dataManager: self.dataManager, with: member, index: index)
    }
    
    
    // Input
    func makeNewMember(_ member: Member) {
        dataManager.makeNewMember(member)
    }
    
    func updateMemberInfo(index: Int, with member: Member) {
        dataManager.updateMemberInfo(index: index, with: member)
    }
    
    
    // Logic
    func handleNextVC(_ index: Int? = nil, fromCurrentVC: UIViewController, animated: Bool) {
        if let index = index {
            let memberVM = memberViewModelAtIndex(index)
            goToNextVC(with: memberVM, fromCurrentVC: fromCurrentVC, animated: animated)
        } else {
            let newVM = MemberViewModel(dataManager: self.dataManager, with: nil, index: nil)
            goToNextVC(with: newVM, fromCurrentVC: fromCurrentVC, animated: animated)
        }
    }
    
    private func goToNextVC(with memberVM: MemberViewModel, fromCurrentVC: UIViewController, animated: Bool) {
        
        let navVC = fromCurrentVC.navigationController
        
        let detailVC = DetailViewController(viewModel: memberVM)
        navVC?.pushViewController(detailVC, animated: animated)
    }
}
