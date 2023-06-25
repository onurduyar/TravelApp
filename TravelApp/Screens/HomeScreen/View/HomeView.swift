//
//  HomeView.swift
//  TravelApp
//
//  Created by Onur Duyar on 25.06.2023.
//

import UIKit
import SnapKit
import SwiftUI

class HomeView: UIView {
    let cardViewHostController: UIHostingController<CardView>
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "deneme"
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    init(cardView: CardView){
        self.cardViewHostController = UIHostingController(rootView: cardView)
        super.init(frame: .zero)
        backgroundColor = .white
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setupConstraints() {
        addSubview(cardViewHostController.view)
        addSubview(titleLabel)
        
        cardViewHostController.view.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(10)
            make.right.equalToSuperview().offset(-16)
            make.left.equalToSuperview().offset(16)
            make.height.equalTo(220)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(cardViewHostController.view.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
        }
    }
    
}

