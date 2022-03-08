//
//  DataDetailCell.swift
//  TinecoTrackData
//
//  Created by psh on 2022/3/2.
//

import UIKit

class DataDetailCell: UITableViewCell {
    let titlelabel = UILabel()
    let subtitleLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        titlelabel.textColor = .black
        titlelabel.font = .boldSystemFont(ofSize: 13)
        titlelabel.numberOfLines = 2
        titlelabel.textAlignment = .center
        contentView.addSubview(titlelabel)
        
        subtitleLabel.textColor = .gray
        subtitleLabel.font = .systemFont(ofSize: 13)
        subtitleLabel.numberOfLines = 0
        contentView.addSubview(subtitleLabel)
        
        titlelabel.snp.makeConstraints { make in
            make.centerY.equalTo(subtitleLabel.snp.centerY)
            make.left.equalTo(10)
            make.width.equalTo(120)
        }
        
        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(10)
            make.left.equalTo(titlelabel.snp.right)
            make.right.lessThanOrEqualToSuperview()
            make.height.greaterThanOrEqualTo(titlelabel.snp.height)
            make.bottom.equalTo(-10)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
