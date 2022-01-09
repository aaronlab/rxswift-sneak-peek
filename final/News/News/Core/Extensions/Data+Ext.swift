//
//  Data+Ext.swift
//  News
//
//  Created by Aaron Lee on 2022/01/09.
//

import Foundation

extension Data {
  func decode<T: Decodable>(_ type: T.Type,
                            keyStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys) -> T? {
    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = keyStrategy
    return try? decoder.decode(type, from: self)
  }
}
