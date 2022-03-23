//
//  GlobalConstant.swift
//  TinecoTrackData
//
//  Created by psh on 2022/3/22.
//

import Foundation

let NAV_HEIGHT = UIApplication.shared.statusBarFrame.height+44
let SCREEN_WIDTH = UIScreen.main.bounds.size.width.float
let SCREEN_HEIGHT = UIScreen.main.bounds.size.height.float

func TLLog<T>(_ message: T, file: String = #file, funcName: String = #function, lineNum: Int = #line) {
    #if DEBUG
        let fileName = (file as NSString).lastPathComponent
        print("\(fileName):(\(lineNum))-\(message)")
    #endif
}
