//
//  MemoDAO.swift
//  MyMemory
//
//  Created by prologue on 2017. 6. 22..
//  Copyright © 2017년 rubypaper. All rights reserved.
//

import UIKit
import CoreData

class MemoDAO {
  lazy var context: NSManagedObjectContext = {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    return appDelegate.persistentContainer.viewContext
  }()
  
  func fetch(keyword text: String? = nil) -> [MemoData] {
    var memolist = [MemoData]()
    
    // 1. 요청 객체 생성
    let fetchRequest: NSFetchRequest<MemoMO> = MemoMO.fetchRequest()
    
    // 1-1. 최신 글 순으로 정렬하도록 정렬 객체 생성
    let regdateDesc = NSSortDescriptor(key: "regdate", ascending: false)
    fetchRequest.sortDescriptors = [regdateDesc]
    
    // 1-2. 검색 키워드가 있을 경우 검색 조건 추가
    if let t = text, t.isEmpty == false {
      fetchRequest.predicate = NSPredicate(format: "contents CONTAINS[c] %@", t)      
    }
    
    do {
      let resultset = try self.context.fetch(fetchRequest)
      
      // 2. 읽어온 결과 집합을 순회하면서 [MemoData] 타입으로 변환한다.
      for record in resultset {
        // 3. MemoData 객체를 생성한다.
        let data = MemoData()
        
        // 4. MemoMO 프로퍼티 값을 MemoData의 프로퍼티로 복사한다.
        data.title = record.title
        data.contents = record.contents
        data.regdate = record.regdate! as Date
        data.objectID = record.objectID
        
        // 4-1. 이미지가 있을 때에만 복사
        if let image = record.image as Data? {
          data.image = UIImage(data: image)
        }
        // 5. MemoData 객체를 memolist 배열에 추가한다.
        memolist.append(data)
      }
    } catch let e as NSError {
      NSLog("An error has occurred : %s", e.localizedDescription)
    }
    return memolist
  }
  
  func insert(_ data: MemoData) {
    // 1. 관리 객체 인스턴스 생성
    let object = NSEntityDescription.insertNewObject(forEntityName: "Memo", into: self.context) as! MemoMO
    
    // 2. MemoData로부터 값을 복사한다.
    object.title = data.title
    object.contents = data.contents
    object.regdate = data.regdate!
    if let image = data.image {
      object.image = UIImagePNGRepresentation(image)!
    }
    
    // 3. 영구 저장소에 변경 사항을 반영한다.
    do {
      try self.context.save()
      
      // 로그인되어 있을 경우 서버에 데이터를 업로드한다.
      let tk = TokenUtils()
      if tk.getAuthorizationHeader() != nil {
        DispatchQueue.global(qos: .background).async {
          UIApplication.shared.isNetworkActivityIndicatorVisible = true // 로딩 시작
          
          // 서버에 데이터를 업로드한다.
          let sync = DataSync()
          sync.uploadDatum(object) {
            UIApplication.shared.isNetworkActivityIndicatorVisible = false // 로딩 중지
          }
        }
      }
      
    } catch let e as NSError {
      NSLog("An error has occurred : %s", e.localizedDescription)
    }
  }
  
  func delete(_ objectID: NSManagedObjectID) -> Bool {
    // 삭제할 객체를 찾아, 컨텍스트에서 삭제한다.
    let object = self.context.object(with: objectID)
    self.context.delete(object)
    
    do {
      // 삭제된 내역을 영구저장소에 반영한다.
      try self.context.save()
      return true
    } catch let e as NSError {
      NSLog("An error has occurred : %s", e.localizedDescription)
      return false
    }
  }
}
