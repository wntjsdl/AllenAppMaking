//
//  MemberViewModel.swift
//  MemberList
//
//  Created by JuSun Kang on 1/8/24.
//

import UIKit

class MemberViewModel {
    
    //MARK: - 관리 모델 선언
    let dataManager: MemberListType
    
    private var member: Member?
    private var index: Int?
    
    init(dataManager: MemberListType, with member: Member? = nil, index: Int? = nil) {
        self.dataManager = dataManager
        self.member = member
        self.index = index
    }
    
    // Output
    var memberImage: UIImage? {
        member?.memberImage
    }
    
    var memberIdString: String? {
        String(member?.memberId ?? Member.memberNumbers)
    }
    
    var nameString: String? {
        member?.name
    }
    
    var ageString: String? {
        member != nil ? String(member!.age!) : ""
    }
    
    var phoneNumString: String? {
        member?.phone
    }
    
    var addressString: String? {
        member?.address
    }
    
    var buttonTitle: String {
        member != nil ? "UPDATE" : "SAVE"
    }
    
    
    // Input
    func handleButtonTapped(image: UIImage?, name: String?, age: String?, phone: String?, address: String) {
        if member != nil {
            updateMember(image: image, name: name, age: age, phone: phone, address: address)
        } else {
            makeNewMember(image: image, name: name, age: age, phone: phone, address: address)
        }
    }
    
    
    // Logic
    private func updateMember(image: UIImage?, name: String?, age: String?, phone: String?, address: String) {
        
        guard let member = self.member, let index = self.index else { return }
        
        let ageInt = Int(age ?? "") ?? 0
        
        self.member = Member(exitingMember: member, image: image, name: name, age: ageInt, phone: phone, address: address)
        
        self.dataManager.updateMemberInfo(index: index, with: self.member!)
        
    }
    
    private func makeNewMember(image: UIImage?, name: String?, age: String?, phone: String?, address: String) {
        
        let ageInt = Int(age ?? "") ?? 0
        
        let newMember = Member(image: image, name: name, age: ageInt, phone: phone, address: address)
        
        self.dataManager.makeNewMember(newMember)
    }
    
    func backToBeforeVC(fromCurrentVC: UIViewController, animated: Bool) {
        let navCon = fromCurrentVC.navigationController
        navCon?.popViewController(animated: animated)
    }
}
