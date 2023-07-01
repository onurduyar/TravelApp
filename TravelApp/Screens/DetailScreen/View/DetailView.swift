//
//  DetailView.swift
//  TravelApp
//
//  Created by Onur Duyar on 27.06.2023.
//

import UIKit

class DetailView: UIView {
    weak var delegate: PlaceDetailVCDelegate?
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    lazy var showOnMapButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Show on Map", for: .normal)
        button.addTarget(self, action: #selector(showOnMapButtonTapped), for: .touchUpInside)
        button.layer.borderWidth = 1.0
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.cornerRadius = 15
        button.backgroundColor = .cyan
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 26)
        let padding: CGFloat = 16.0
        button.contentEdgeInsets = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        tableView.register(DetailCell.self, forCellReuseIdentifier: "detailCell")
        setupTableView()
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupTableView() {
        addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupButton() {
        addSubview(showOnMapButton)
        showOnMapButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-30)
        }
    }
    
    @objc private func showOnMapButtonTapped() {
        delegate?.showOnMapButtonTapped()
    }
    
    func refresh() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

