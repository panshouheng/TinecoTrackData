//
//  FloatingSelectionView.swift
//  TinecoTrackData
//
//  Created by psh on 2022/2/28.
//

import UIKit
import RxSwift
class SelectPopView: UIView {

    private let tableView = UITableView(frame: CGRect.zero, style: UITableView.Style.plain)
    private var selectClosure: ((SectionItemModel, Int) -> Void)?
    private(set) var dataArray: [SectionItemModel] = [] {
        didSet {
            let showCount = min(5, dataArray.count)
            tableView.isScrollEnabled = dataArray.count>5
            tableView.snp.makeConstraints { make in
                make.height.equalTo(40*showCount)
            }
            tableView.reloadData()
        }
    }
    static var isShowing: Bool {
        guard let window = UIApplication.shared.keyWindow else { return false }
        return window.subviews.contains { $0.isKind(of: SelectPopView.self)}
    }
    
    static func show(_ location: CGRect, _ dataArray: [SectionItemModel]?, selectClosure: @escaping (_ selectModel: SectionItemModel, _ index: Int) -> Void) {
        guard let window = UIApplication.shared.keyWindow, let dataArray = dataArray else { return }
        window.subviews.filter { $0.isKind(of: SelectPopView.self) }.forEach { $0.removeFromSuperview() }
        let maxWidth = max(dataArray.map { $0.item_width }.sorted(by: >)[0], SCREEN_WIDTH/5)
        let locationX = (UIScreen.main.bounds.width - location.minX).float.cgFloat<maxWidth.cgFloat ? (location.maxX.float.cgFloat-maxWidth.cgFloat).float : location.minX.float
        let selectView = SelectPopView(frame: .zero)
        selectView.selectClosure = selectClosure
        selectView.dataArray = dataArray
        window.addSubview(selectView)
        selectView.snp.makeConstraints { make in
            make.left.equalTo(locationX)
            make.top.equalTo(location.maxY.float)
            make.width.equalTo(maxWidth)
        }
    }
    static func dismiss() {
        guard let window = UIApplication.shared.keyWindow else { return }
        window.subviews.filter { $0.isKind(of: SelectPopView.self) }.forEach { $0.removeFromSuperview() }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 40
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: NSStringFromClass(UITableViewCell.self))
        tableView.isScrollEnabled = false
        tableView.backgroundColor = .lightGray
        self.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SelectPopView: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(UITableViewCell.self))! as UITableViewCell
        cell.backgroundColor = .clear
        cell.textLabel?.text = self.dataArray[indexPath.row].name
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.font = UIFont.systemFont(ofSize: 13)
        cell.textLabel?.snp.makeConstraints({ make in
            make.edges.equalToSuperview()
        })
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let selectClosure = self.selectClosure else { return  }
        Self.dismiss()
        selectClosure(self.dataArray[indexPath.row], indexPath.row)
    }
    
}
