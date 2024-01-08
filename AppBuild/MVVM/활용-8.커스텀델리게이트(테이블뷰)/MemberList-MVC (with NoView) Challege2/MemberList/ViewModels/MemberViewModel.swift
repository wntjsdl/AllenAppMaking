//
//  MemberViewModel.swift
//  MemberList
//
//  Created by JuSun Kang on 1/8/24.
//

import UIKit

class MemberViewModel {
    
    let dataManager: MemberListManager
    
    var member: Member?
    let index: Int?
    
    init(dataManager: MemberListManager, with member: Member?, index: Int?) {
        self.dataManager = dataManager
        self.member = member
        self.index = index
    }
    
    // MARK: - Output
    var memberImage: UIImage? {
        member?.memberImage
    }
    
    var memberIdString: String? {
        String(member?.memberId ?? Member.memberNumbers)
    }
    
    var nameString: String? {
        member?.name
    }
    
    var addressString: String? {
        member?.address
    }
    
    var phoneString: String? {
        member?.phone
    }
    
    var ageString: String? {
        member != nil ? String(member!.age!) : ""
    }
    
    var buttonTitle: String {
        member != nil ? "UPDATE" : "SAVE"
    }
    
    
    // MARK: - Input
    func handleButtonTapped(image: UIImage?, name: String?, age: String?, phone: String?, address: String?) {
        if member != nil {
            updateMember(image: image, name: name, age: age, phone: phone, address: address)
        } else {
            makeNewMember(name: name, age: age, phone: phone, address: address)
        }
    }
    
    
    // MARK: - Logic
    func updateMember(image: UIImage?, name: String?, age: String?, phone: String?, address: String?) {
        
        guard let member = self.member, let index = self.index else { return }
        
        let ageInt = Int(age ?? "") ?? 0
        
        self.member = Member(existingMember: member, image: image, name: name, age: ageInt, phone: phone, address: address)
        dataManager.updateMemberInfo(index: index, with: self.member!)
    }
    
    // 새 멤버 만들기
    func makeNewMember(name: String?, age: String?, phone: String?, address: String?) {
        let ageInt = Int(age ?? "") ?? 0
        
        let newMember = Member(name: name, age: ageInt, phone: phone, address: address)
        dataManager.makeNewMember(newMember)
    }
    
    // 이전화면으로 돌아가기
    func backToBeforeVC(fromCurrentVC: UIViewController, animated: Bool) {
        let navCon = fromCurrentVC.navigationController
        navCon?.popViewController(animated: animated)
    }
    
    
    
    
    
}
