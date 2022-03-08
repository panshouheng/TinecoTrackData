//
//  OperationView.swift
//  TinecoTrackData
//
//  Created by psh on 2022/2/24.
//

import UIKit
class OperationView: UIView, OperationViewDelegate {
    
    let titleLabel = UILabel()
    let leftLabel = UILabel()
    let inputTextfield = UITextField()
    let buttonBgView = UIView()
    
    var section: Int = 0
    
    var model: OperationModel? {
        didSet {
            guard let model = model else {return }
            titleLabel.text = model.title
            leftLabel.text = model.subtitle
            inputTextfield.placeholder = model.placeholder
            leftLabel.sizeToFit()
            leftLabel.snp.makeConstraints { make in
                make.width.equalTo(leftLabel.width)
            }
            
            for index in 0..<model.titles_button.count {
                let button = UIButton(type: .custom)
                button.backgroundColor = .gray
                button.setTitle(model.titles_button[index].button_title, for: .normal)
                button.tag = model.titles_button[index].item
                self.buttonBgView.addSubview(button)
                button.snp.makeConstraints { make in
                    make.left.equalTo(index%2*((UIScreen.main.bounds.width.int-60)/2+10)+20)
                    make.top.equalTo(index/2*60+10)
                    make.size.equalTo(CGSize(width: (UIScreen.main.bounds.width-60)/2, height: 50))
                    if index == model.titles_button.count-1 {
                        make.bottom.equalToSuperview()
                    }
                }
                button.addTarget(self, action: #selector(buttonClick(_:)), for: .touchUpInside)
            }
        }
    }
    @objc func buttonClick(_ sender: UIButton) {
        guard let model = model else {return}
        self.didSelect(inputTextfield.text, model, model.titles_button[sender.tag])
    }
    convenience init(section: Int) {
        self.init(frame: .zero)
        self.section = section
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        titleLabel.backgroundColor = UIColor.lightGray
        titleLabel.textColor = UIColor.black
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        titleLabel.numberOfLines = 0
        addSubview(titleLabel)
        
        leftLabel.textColor = UIColor.black
        leftLabel.font = UIFont.boldSystemFont(ofSize: 20)
        leftLabel.numberOfLines = 2
        leftLabel.textAlignment = .center
        addSubview(leftLabel)
        
        inputTextfield.layer.borderWidth = 1
        inputTextfield.layer.borderColor = UIColor.black.cgColor
        inputTextfield.textColor = UIColor.black
        inputTextfield.font = UIFont.boldSystemFont(ofSize: 16)
        addSubview(inputTextfield)
        
        addSubview(buttonBgView)
        
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(20)
            make.right.lessThanOrEqualTo(-20)
            make.top.equalTo(self)
        }
        
        leftLabel.snp.makeConstraints { make in
            make.left.equalTo(20)
            make.top.equalTo(titleLabel.snp.bottom).offset(30)
        }
        inputTextfield.snp.makeConstraints { make in
            make.left.equalTo(leftLabel.snp.right).offset(10)
            make.height.equalTo(50)
            make.centerY.equalTo(leftLabel.snp.centerY)
            make.right.equalTo(-20)
        }
        
        buttonBgView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(inputTextfield.snp.bottom)
            make.bottom.equalToSuperview().offset(-40)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
