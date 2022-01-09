//
//  Output.swift
//  News
//
//  Created by Aaron Lee on 2022/01/09.
//

import Foundation

protocol Output {
  associatedtype Output

  var output: Output { get }

  func bindOutput()
}
