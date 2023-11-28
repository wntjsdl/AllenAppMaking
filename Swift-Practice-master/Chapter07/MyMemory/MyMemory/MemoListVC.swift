//
//  MemoListVC.swift
//  MyMemory
//
//  Created by prologue on 2017. 6. 6..
//  Copyright © 2017년 rubypaper. All rights reserved.
//

import UIKit

class MemoListVC: UITableViewController, UISearchBarDelegate {
  lazy var dao = MemoDAO() // STEP 1)
  
  @IBOutlet var searchBar: UISearchBar!
  
  // 앱 델리게이트 객체의 참조 정보를 읽어온다.
  let appDelegate = UIApplication.shared.delegate as! AppDelegate
  
  override func viewDidLoad() {
    // 검색 바의 키보드에서 리턴 키가 항상 활성화되어 있도록 처리
    searchBar.enablesReturnKeyAutomatically = false
    
    // SWRevealViewController 라이브러리의 revealViewController 객체를 읽어온다.
    if let revealVC = self.revealViewController() {
      // 바 버튼 아이템 객체를 정의한다.
      let btn = UIBarButtonItem()
      btn.image = UIImage(named: "sidemenu.png") // 이미지는 sidemenu.png로
      btn.target = revealVC // 버튼 클릭 시 호출할 메소드가 정의된 객체를 지정
      btn.action = #selector(revealVC.revealToggle(_:)) // 버튼 클릭 시 revealToggle(_:) 호출
      
      // 정의된 바 버튼을 내비게이션 바의 왼쪽 아이템으로 등록한다.
      self.navigationItem.leftBarButtonItem = btn
      
      // 제스처 객체를 뷰에 추가한다.
      self.view.addGestureRecognizer(revealVC.panGestureRecognizer())
    }
  }
  
  // 디바이스 스크린에 뷰 컨트롤러가 나타날 때마다 호출되는 메소드
  override func viewWillAppear(_ animated: Bool) {
    let ud = UserDefaults.standard
    if ud.bool(forKey: UserInfoKey.tutorial) == false {
      let vc = self.instanceTutorialVC(name: "MasterVC")
      self.present(vc!, animated: false)
      return
    }
    
    // STEP 2) 코어 데이터에 저장된 데이터를 가져온다.
    self.appDelegate.memolist = self.dao.fetch()
    
    // 테이블 데이터를 다시 읽어들인다. 이에 따라 행을 구성하는 로직이 다시 실행될 것이다.
    self.tableView.reloadData()
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    let count = self.appDelegate.memolist.count
    return count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    // 1. memolist 배열 데이터에서 주어진 행에 맞는 데이터를 꺼낸다.
    let row = self.appDelegate.memolist[indexPath.row]
    
    // 2. 이미지 속성이 비어 있을 경우 "memoCell", 아니면 "memoCellWithImage"
    let cellId = row.image == nil ? "memoCell" : "memoCellWithImage"
    
    // 3. 재사용 큐로부터 프로포타입 셀의 인스턴스를 전달받는다.
    let cell = tableView.dequeueReusableCell(withIdentifier: cellId) as! MemoCell
    
    // 4. memoCell의 내용을 구성한다.
    cell.subject?.text = row.title
    cell.contents?.text = row.contents
    cell.img?.image = row.image
    
    // 5. Date 타입의 날짜를 yyyy-MM-dd HH:mm:ss 포맷에 맞게 변경한다.
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    cell.regdate?.text = formatter.string(from: row.regdate!)
    
    // 6. cell 객체를 리턴한다.
    return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    // ① memolist 배열에서 선택된 행에 맞는 데이터를 꺼낸다.
    let row = self.appDelegate.memolist[indexPath.row]
    
    // ② 상세 화면의 인스턴스를 생성한다.
    guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "MemoRead") as? MemoReadVC else {
      return
    }
    
    // ③ 값을 전달한 다음, 상세 화면으로 이동한다.
    vc.param = row
    self.navigationController?.pushViewController(vc, animated: true)
  }
  
  override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
    return .delete
  }
  
  override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    let data = self.appDelegate.memolist[indexPath.row]
    
    // 코어 데이터에서 삭제한 다음, 배열 내 데이터 및 테이블 뷰 행을 차례로 삭제한다.
    if dao.delete(data.objectID!) {
      self.appDelegate.memolist.remove(at: indexPath.row)
      self.tableView.deleteRows(at: [indexPath], with: .fade)
    }
  }
  
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    let keyword = searchBar.text // 검색 바에 입력된 키워드를 가져온다.
    
    // 키워드를 적용하여 데이터를 검색하고, 테이블 뷰를 갱신한다.
    self.appDelegate.memolist = self.dao.fetch(keyword: keyword)
    self.tableView.reloadData()
  }
}
