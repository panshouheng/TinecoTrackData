//
//  SectionViewCell.swift
//  TinecoTrackData
//
//  Created by psh on 2022/3/2.
//

import UIKit
import RxSwift
class SecondViewCell: UITableViewCell {
    
    var labelArray = [UILabel]()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        for index in 0...3 {
            let label = UILabel()
            label.textColor = .gray
            label.font = .systemFont(ofSize: 14)
            label.textAlignment = .center
            label.numberOfLines = 0
            contentView.addSubview(label)
            
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
