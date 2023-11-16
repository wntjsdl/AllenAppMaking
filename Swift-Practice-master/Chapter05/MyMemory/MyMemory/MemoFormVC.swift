//
//  MemoFormVC.swift
//  MyMemory
//
//  Created by prologue on 2017. 6. 6..
//  Copyright © 2017년 rubypaper. All rights reserved.
//

import UIKit

class MemoFormVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate {
  var subject: String!
  
  @IBOutlet var contents: UITextView!
  @IBOutlet var preview: UIImageView!
  
  override func viewDidLoad() {
    self.contents.delegate = self
    
    // 배경 이미지 설정
    let bgImage = UIImage(named:"memo-background.png")!
    self.view.backgroundColor = UIColor(patternImage: bgImage)
    
    // 텍스트 뷰의 기본 속성
    self.contents.layer.borderWidth = 0
    self.contents.layer.borderColor = UIColor.clear.cgColor
    self.contents.backgroundColor = UIColor.clear
    
    // 줄 간격
    let style = NSMutableParagraphStyle()
    style.lineSpacing = 9
    self.contents.attributedText = NSAttributedString(string: " ",
                                                      attributes: [NSAttributedStringKey.paragraphStyle: style])
    self.contents.text = ""
  }
  
  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    let bar = self.navigationController?.navigationBar
    let ts = TimeInterval(0.3)
    UIView.animate(withDuration: ts) {
      bar?.alpha = ( bar?.alpha == 0 ? 1 : 0 )
    }
  }
  
  // 저장 버튼을 클릭했을 때 호출되는 메소드
  @IBAction func save(_ sender: Any) {
    // 경고창에 사용될 콘텐츠 뷰 컨트롤러 구성
    let alertV = UIViewController()
    let iconImage = UIImage(named: "warning-icon-60")
    alertV.view = UIImageView(image: iconImage)
    alertV.preferredContentSize = iconImage?.size ?? CGSize.zero
    
    // ① 내용을 입력하지 않았을 경우, 경고한다.
    guard self.contents.text?.isEmpty == false else {
      let alert = UIAlertController(title: nil,
                                    message: "내용을 입력해주세요",
                                    preferredStyle: .alert)
      alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
      // 추가된 구문) 콘텐츠 뷰 영역에 alertV를 등록한다.
      alert.setValue(alertV, forKey: "contentViewController")
      self.present(alert, animated: true)
      return
    }
    // ② MemoData 객체를 생성하고, 데이터를 담는다.
    let data = MemoData()
    
    data.title = self.subject // 제목
    data.contents = self.contents.text // 내용
    data.image = self.preview.image // 이미지
    data.regdate = Date() // 작성 시각
    
    // ③ 앱 델리게이트 객체를 읽어온 다음, memolist 배열에 MemoData 객체를 추가한다.
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    appDelegate.memolist.append(data)
    
    // ④ 작성폼 화면을 종료하고, 이전 화면으로 되돌아간다.
    _ = self.navigationController?.popViewController(animated: true)
  }
  
  // 카메라 버튼을 클릭했을 때 호출되는 메소드
  @IBAction func pick(_ sender: Any) {
    let select = UIAlertController(title: "이미지를 가져올 곳을 선택해주세요.", message: nil, preferredStyle: .actionSheet)
    select.addAction(UIAlertAction(title: "카메라", style: .default) { (_) in
      self.presentPicker(source: .camera)
    })
    select.addAction(UIAlertAction(title: "저장앨범", style: .default) { (_) in
        self.presentPicker(source: .savedPhotosAlbum)
    })
    select.addAction(UIAlertAction(title: "사진 라이브러리", style: .default) { (_) in
        self.presentPicker(source: .photoLibrary)
    })
    self.present(select, animated: false)
  }
  
  // 실제로 이미지 피커를 실행하는 메소드
  func presentPicker(source: UIImagePickerControllerSourceType) {
    guard UIImagePickerController.isSourceTypeAvailable(source) == true else {
      let alert = UIAlertController(title: "사용할 수 없는 타입입니다", message: nil, preferredStyle: .alert)
      self.present(alert, animated: false)
      return
    }
    
    // 이미지 피커 인스턴스를 생성한다.
    let picker = UIImagePickerController()
    
    picker.delegate = self
    picker.allowsEditing = true
    picker.sourceType = source
    
    // 이미지 피커 화면을 표시한다.
    self.present(picker, animated: false)
  }
  
  // 이미지 선택을 완료했을 때 호출되는 메소드
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
    // 선택된 이미지를 미리보기에 표시한다.
    self.preview.image = info[UIImagePickerControllerEditedImage] as? UIImage
    
    // 이미지 피커 컨트롤러를 닫는다.
    picker.dismiss(animated: false)
  }
  
  func textViewDidChange(_ textView: UITextView) {
    // 내용의 최대 15자리까지 읽어 subject 변수에 저장한다.
    let contents = textView.text as NSString
    let length = ( (contents.length > 15) ? 15 : contents.length )
    self.subject = contents.substring(with: NSRange(location: 0, length: length))
    
    // 내비게이션 타이틀에 표시한다.
    self.navigationItem.title = subject
  }
}
