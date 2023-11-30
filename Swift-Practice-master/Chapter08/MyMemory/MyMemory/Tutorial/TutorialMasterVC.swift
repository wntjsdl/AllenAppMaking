//
//  TutorialMasterVC.swift
//  MyMemory
//
//  Created by prologue on 2017. 6. 11..
//  Copyright © 2017년 rubypaper. All rights reserved.
//

class TutorialMasterVC: UIViewController, UIPageViewControllerDataSource {
  var pageVC: UIPageViewController!
  
  // 콘텐츠 뷰 컨트롤러에 들어갈 타이틀과 이미지
  var contentTitles = ["STEP 1", "STEP 2", "STEP 3", "STEP 4"]
  var contentImages = ["Page0", "Page1", "Page2", "Page3"]
  
  @IBAction func close(_ sender: Any) {
    let ud = UserDefaults.standard
    ud.set(true, forKey: UserInfoKey.tutorial)
    ud.synchronize()
    
    self.presentingViewController?.dismiss(animated: true)
  }
  
  override func viewDidLoad( ) {
    // 1. 페이지 뷰 컨트롤러 객체 생성하기
    self.pageVC = self.instanceTutorialVC(name: "PageVC") as! UIPageViewController
    self.pageVC.dataSource = self
    
    // 2. 페이지 뷰 컨트롤러의 기본 페이지 지정
    let startContentVC = self.getContentVC(atIndex: 0)! // 최초 노출될 콘텐츠 뷰 컨트롤러
    self.pageVC.setViewControllers([startContentVC], direction: .forward, animated: true)
    
    // 3. 페이지 뷰 컨트롤러의 출력 영역 지정
    self.pageVC.view.frame.origin = CGPoint(x: 0, y: 0)
    self.pageVC.view.frame.size.width = self.view.frame.width
    self.pageVC.view.frame.size.height = self.view.frame.height - 50
    
    // 4. 페이지 뷰 컨트롤러를 마스터 뷰 컨트롤러의 자식 뷰 컨트롤러로 설정
    self.addChildViewController(self.pageVC) // ①
    self.view.addSubview(self.pageVC.view) // ②
    self.pageVC.didMove(toParentViewController: self) // ③
  }
  
  func getContentVC(atIndex idx: Int) -> UIViewController? {
    // 인덱스가 데이터 배열 크기 범위를 벗어나면 nil 반환
    guard self.contentTitles.count >= idx && self.contentTitles.count > 0 else {
      return nil
    }
    // "ContentsVC"라는 Storyboard ID를 가진 뷰 컨트롤러의 인스턴스를 생성하고 캐스팅한다.
    guard let cvc = self.instanceTutorialVC(name: "ContentsVC") as?
      TutorialContentsVC else {
        return nil
    }
    // 콘텐츠 뷰 컨트롤러의 내용을 구성
    cvc.titleText = self.contentTitles[idx]
    cvc.imageFile = self.contentImages[idx]
    cvc.pageIndex = idx
    return cvc
  }
  
  // 현재의 콘텐츠 뷰 컨트롤러보다 앞쪽에 올 콘텐츠 뷰 컨트롤러 객체
  // 즉, 현재의 상태에서 앞쪽으로 스와이프했을 때 보여줄 콘텐츠 뷰 컨트롤러 객체
  func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
      // 현재의 페이지 인덱스
      guard var index = (viewController as! TutorialContentsVC).pageIndex else {
        return nil
      }
      // 현재의 인덱스가 맨 앞이라면 nil을 반환하고 종료
      guard index > 0 else {
        return nil
      }
      index -= 1 // 현재의 인덱스에서 하나 뺌(즉, 이전 페이지 인덱스)
      return self.getContentVC(atIndex: index)
  }
  
  // 현재의 콘텐츠 뷰 컨트롤러보다 뒤쪽에 올 콘텐츠 뷰 컨트롤러 객체
  // 즉, 현재의 상태에서 뒤쪽으로 스와이프했을 때 보여줄 콘텐츠 뷰 컨트롤러 객체
  func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
      // 현재의 페이지 인덱스
      guard var index = (viewController as! TutorialContentsVC).pageIndex else {
        return nil
      }
      index += 1 // 현재의 인덱스에 하나를 더함(즉, 다음 페이지 인덱스)
      // 인덱스는 항상 배열 데이터의 크기보다 작아야 한다.
      guard index < self.contentTitles.count else {
        return nil
      }
      return self.getContentVC(atIndex: index)
  }
  
  func presentationCount(for pageViewController: UIPageViewController) -> Int {
    return self.contentTitles.count
  }
  
  func presentationIndex(for pageViewController: UIPageViewController) -> Int {
    return 0
  }
}
