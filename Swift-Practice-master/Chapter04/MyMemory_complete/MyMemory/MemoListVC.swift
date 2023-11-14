//
//  MemoListVC.swift
//  MyMemory
//
//  Created by prologue on 2017. 6. 6..
//  Copyright © 2017년 rubypaper. All rights reserved.
//

import UIKit

class MemoListVC: UITableViewController {
  
  // 앱 델리게이트 객체의 참조 정보를 읽어온다.
  let appDelegate = UIApplication.shared.delegate as! AppDelegate
  
  override func viewDidLoad() {
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
    
    /* 이 부분은 테스트를 위한 더미 데이터 코드입니다.
     실제 실습 진행시에는 관련 코드를 삭제하시기 바랍니다.*/
    
    let memo = MemoData()
    memo.title = "워크샵 준비 물품들"
    memo.contents = "라면, 양파, 감자, 파, 계란, 세제류, 생수, 탄산수, 워셔액, 비누, 치약, 칫솔, 수건, 라면, 양파, 감자, 파, 계란, 세제류, 생수, 탄산수, 워셔액, 비누, 치약, 칫솔, 수건"
    memo.regdate = Date()
    
    appDelegate.memolist.append(memo)
    
    let memo1 = MemoData()
    memo1.title = "워크샵 출발 전 챙겨야 할 것들"
    memo1.contents = "이동중 섭취물품들, 인원 체크 및 예약장소 재확인"
    memo1.regdate = Date(timeIntervalSinceNow: 3000)
    
    appDelegate.memolist.append(memo1)
    
    let memo2 = MemoData()
    memo2.title = "출발 전 체크 항목들"
    memo2.contents = "인원별 탑승 완료 여부 확인 및 각 이동 차량 점검"
    memo2.regdate = Date(timeIntervalSinceNow: 4000)
    
    appDelegate.memolist.append(memo2)
    
    let memo3 = MemoData()
    memo3.title = "워크샵 결과 정리"
    memo3.contents = "부족했던 점 : 워크샵 장소 이동 사이에 간격이 너무 길어 사람들의 주의가 분산됨"
    memo3.regdate = Date(timeIntervalSinceNow: 8000)
    
    appDelegate.memolist.append(memo3)
  }
  
  // 디바이스 스크린에 뷰 컨트롤러가 나타날 때마다 호출되는 메소드
  override func viewWillAppear(_ animated: Bool) {
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
}
