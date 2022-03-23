//
//  ContentView.swift
//  TinecoTrackData
//
//  Created by psh on 2022/3/22.
//

import UIKit
import RxSwift

class ContentView: UIView {
    
    var labelArray = [UILabel]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .lightGray
        for index in 0...3 {
            let label = UILabel()
            label.textColor = .black
            label.font = .systemFont(ofSize: 14)
            label.textAlignment = .center
            label.tag = index
            self.addSubview(label)
            
            label.snp.makeConstraints { make in
                make.left.equalTo(SCREEN_WIDTH.int/4*index)
                make.top.height.equalToSuperview()
                make.width.equalTo(SCREEN_WIDTH.int/4)
            }
            labelArray.append(label)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension Reactive where Base: ContentView {
    var titles: Binder<[String]> {
        return Binder(base) { view, result in
            for idx in 0..<result.count {
                let label = view.labelArray[idx]
                label.text = result[idx]
            }
        }
    }
}
