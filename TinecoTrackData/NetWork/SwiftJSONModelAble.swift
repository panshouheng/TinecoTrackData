//
//  SwiftJSONModelAble.swift
//  TinecoTrackData
//
//  Created by psh on 2022/3/15.
//

import Foundation
import SwiftyJSON

public protocol SwiftJSONModelAble {
    init(_ jsonData: JSON)
}
