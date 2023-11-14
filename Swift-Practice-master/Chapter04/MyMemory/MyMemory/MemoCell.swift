//
//  MemoCell.swift
//  MyMemory
//
//  Created by prologue on 2017. 6. 6..
//  Copyright © 2017년 rubypaper. All rights reserved.
//

import UIKit

class MemoCell: UITableViewCell {

  @IBOutlet var subject: UILabel!  // 메모 제목
  @IBOutlet var contents: UILabel! // 메모 내용
  @IBOutlet var regdate: UILabel!  // 등록 일자
  @IBOutlet var img: UIImageView!  // 이미지
}
