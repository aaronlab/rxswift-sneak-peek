//
//  Encodable+Ext.swift
//  News
//
//  Created by Aaron Lee on 2022/01/09.
//

import Foundation

extension Encodable {
  func toJson() -> Data? {
    try? JSONEncoder().encode(self)
  }
}
