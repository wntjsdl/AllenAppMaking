//
//  MemberViewModel.swift
//  MemberList
//
//  Created by JuSun Kang on 1/9/24.
//

import UIKit

class MemberViewModel {
    
    let dataManager: MemberListManager
    
    private var member: Member?
    private var index: Int?
    
    init(dataManager: MemberListManager, member: Member? = nil, index: Int? = nil) {
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
    
    var phoneString: String? {
        member?.phone
    }
    
    var addressString: String? {
        member?.address
    }
    
    var ageString: String? {
        member != nil ? String(member!.age!) : ""
    }
    
    var buttonTitle: String {
        member != nil ? "UPDATE" : "SAVE"
    }
    
    
    
    
    // MARK: - Input
    
    func handleButtonTapped(image: UIImage?, name: String?, age: String?, phone: String, address: String) {
        if member != nil {
            updateMember(image: image, name: name, age: age, phone: phone, address: address)
        } else {
            saveNewMember(image: image, name: name, age: age, phone: phone, address: address)
        }
    }
    
    
    
    // MARK: - Logic
    
    func updateMember(image: UIImage?, name: String?, age: String?, phone: String, address: String) {
        
        guard let member = self.member, let index = self.index else { return }
        
        let ageInt = Int(age ?? "") ?? 0
        
        self.member = Member(exitingMember: member, image: image, name: name, age: ageInt, phone: phone, address: address)
        
        dataManager.updateMemberInfo(index: index, with: member)
    }
    
    func saveNewMember(image: UIImage?, name: String?, age: String?, phone: String, address: String) {
        
        let ageInt = Int(age ?? "") ?? 0
        
        let member = Member(image: image, name: name, age: ageInt, phone: phone, address: address)
        
        dataManager.makeNewMember(member)
    }
    
    func backToBeforeVC(fromCurrentVC: UIViewController, animated: Bool) {
        fromCurrentVC.navigationController?.popViewController(animated: animated)
    }
    
    
    
    
}
