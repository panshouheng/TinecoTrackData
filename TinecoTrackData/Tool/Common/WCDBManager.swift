//
//  WCDBManager.swift
//  TinecoTrackData
//
//  Created by psh on 2022/3/23.
//

import Foundation
import WCDBSwift

class WCDBManager {
    static let shared = WCDBManager.init()
    static let path = URL(fileURLWithPath: NSSearchPathForDirectoriesInDomains(.documentDirectory,
                                                                        .userDomainMask,
                                                                        true).last! + "/tineco.db")
    var dataBase = Database(withFileURL: path)
    
    private init() { }
}
