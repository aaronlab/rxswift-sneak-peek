//
//  OperationQueue+Ext.swift
//  News
//
//  Created by Aaron Lee on 2022/01/09.
//

import Foundation

extension OperationQueue {
  /// Create Operation Queue
  ///
  /// Default is utility queue
  convenience init(label: String,
                   operationQos: QualityOfService = .utility,
                   maxConcurrentOperationCount: Int = OperationQueue
                     .defaultMaxConcurrentOperationCount,
                   queueQos: DispatchQoS = .utility,
                   attributes: DispatchQueue.Attributes = [],
                   autoreleaseFrequency: DispatchQueue.AutoreleaseFrequency = .inherit,
                   target: DispatchQueue? = nil) {
    self.init()
    qualityOfService = operationQos
    self.maxConcurrentOperationCount = maxConcurrentOperationCount
    name = label
    let underlyingQueue = DispatchQueue(label: label,
                                        qos: queueQos,
                                        attributes: attributes,
                                        autoreleaseFrequency: autoreleaseFrequency,
                                        target: target)

    self.underlyingQueue = underlyingQueue
  }
}
