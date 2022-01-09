//
//  Loadable.swift
//  News
//
//  Created by Aaron Lee on 2022/01/09.
//

import Foundation
import RxCocoa

protocol Lodable {
  var loading: BehaviorRelay<Bool> { get }
}

extension Lodable {
  var isLoading: Bool {
    loading.value
  }

  func beginLoading() {
    loading.accept(true)
  }

  func endLoading() {
    loading.accept(false)
  }
}
