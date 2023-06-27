//
//  DetailView.swift
//  TravelApp
//
//  Created by Onur Duyar on 27.06.2023.
//

import UIKit

class DetailView: UIView {
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    override init(frame: CGRect) {
        super.init(frame: .zero)
        tableView.register(DetailCell.self, forCellReuseIdentifier: "detailCell")
        setupTableView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setupTableView(){
        addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    
    
}
