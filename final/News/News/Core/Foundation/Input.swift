//
//  Input.swift
//  News
//
//  Created by Aaron Lee on 2022/01/09.
//

import Foundation

protocol Input {
  associatedtype Input

  var input: Input { get }

  func bindInput()
}
