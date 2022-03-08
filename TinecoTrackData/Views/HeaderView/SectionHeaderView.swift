//
//  File.swift
//  TinecoTrackData
//
//  Created by psh on 2022/2/25.
//

import UIKit
import RxCocoa
import RxSwift
let reuseridentifier = "SectionHeaderViewReuseridentifier"
class SectionHeaderView: UIView {
    
    let bag = DisposeBag()
    
    var collectionView: UICollectionView?
    
    public var reloadSubject = PublishSubject<[SectionItemModel]>()
    public var itemSelected = PublishSubject<(IndexPath, CGRect)>()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width/5.cgFloat, height: 50)
        let collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.register(SectionCollectionViewCell.self, forCellWithReuseIdentifier: reuseridentifier)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.contentInsetAdjustmentBehavior = .never
        self.addSubview(collectionView)
        self.collectionView = collectionView
        
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalTo(UIScreen.main.bounds.width)
            make.height.equalTo(layout.itemSize.height)
        }
        collectionView.rx.itemSelected.subscribe({[weak self] event in
            guard let indexPath = event.element, let self = self else { return }
            guard let frame = collectionView.layoutAttributesForItem(at: indexPath)?.frame, let window = UIApplication.shared.keyWindow else { return  }
            let cellRect = collectionView.convert(frame, to: window)
            self.itemSelected.onNext((indexPath, cellRect))
         }).disposed(by: bag)

        reloadSubject.bind(to: collectionView.rx.items(cellIdentifier: reuseridentifier, cellType: SectionCollectionViewCell.self)) { _, model, cell in
            cell.titleLabel.text = model.name
        }.disposed(by: bag)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
