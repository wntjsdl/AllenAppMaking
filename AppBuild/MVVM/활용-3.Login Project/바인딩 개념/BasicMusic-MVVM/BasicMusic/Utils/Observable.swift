//
//  Observable.swift
//  BasicMusic
//
//  Created by JuSun Kang on 1/10/24.
//

import Foundation

class Observable<T> {
    
    var data: T {
        didSet {
            onComplete?(data)
        }
    }
    
    var onComplete: ((T) -> Void)?
    
    init(_ data: T) {
        self.data = data
    }
    
    func bind(callBack: @escaping (T) -> Void) {
        self.onComplete = callBack
    }
}
