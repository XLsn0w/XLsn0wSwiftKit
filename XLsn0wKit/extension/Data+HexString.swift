//
//  DataExtension.swift
//  Notification
//
//  Created by ginlong on 2018/5/18.
//  Copyright © 2018年 wsj. All rights reserved.
//

import Foundation

extension Data {
    var hexString: String {
        return withUnsafeBytes {(bytes: UnsafePointer<UInt8>) -> String in
            let buffer = UnsafeBufferPointer(start: bytes, count: count)
            return buffer.map {String(format: "%02hhx", $0)}.reduce("", { $0 + $1 })
        }
    }
}
