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
    weak var delegate: HomeViewDelegate?
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()
    
    let circleInfo: [(imageName: String, labelText: String)] = [("hostel_icon", "Hotels"), ("restaurant_icon", "Restaurants"), ("attraction_icon", "Attractions")]
    
    private var circleViews: [UIView] = []
    private var circleTextLabels: [UILabel] = []
    private var circleImageViews: [UIImageView] = []
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        return stackView
    }()
    
    init(cardView: CardView) {
        self.cardViewHostController = UIHostingController(rootView: cardView)
        super.init(frame: .zero)
        
        backgroundColor = .white
        self.addSubview(activityIndicator)
        self.activityIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        activityIndicator.startAnimating()
        setupConstraints()
        
        setupCircleView()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        addSubview(cardViewHostController.view)
        
        cardViewHostController.view.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(10)
            make.right.equalToSuperview().offset(-16)
            make.left.equalToSuperview().offset(16)
            make.height.equalTo(220)
        }
        
        addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.top.equalTo(cardViewHostController.view.snp.bottom).offset(50)
            make.left.right.equalToSuperview()
            make.height.equalTo(80)
        }
    }
    private func setupCircleView() {
        
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            for info in self.circleInfo.enumerated() {
                let circleView = UIView()
                circleView.backgroundColor = .clear
                circleView.layer.cornerRadius = 25
                
                let imageView = UIImageView(image: UIImage(named: info.element.imageName))
                imageView.contentMode = .scaleAspectFit
                
                let label = UILabel()
                label.text = info.element.labelText
                label.font = UIFont.systemFont(ofSize: 12)
                label.textAlignment = .center
                label.textColor = .black
                
                circleView.addSubview(imageView)
                circleView.addSubview(label)
                
                imageView.snp.makeConstraints { make in
                    make.center.equalToSuperview()
                    make.width.height.equalTo(80)
                }
                
                label.snp.makeConstraints { make in
                    make.top.equalTo(imageView.snp.bottom).offset(5)
                    make.centerX.equalToSuperview()
                }
                self.circleViews.append(circleView)
                self.circleImageViews.append(imageView)
                self.circleTextLabels.append(label)
                self.stackView.addArrangedSubview(circleView)
                let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.circleTapped(_:)))
                circleView.addGestureRecognizer(tapGesture)
                circleView.isUserInteractionEnabled = true
                circleView.tag = info.offset
            }
        }
    }
    private func navigateToPage(withTag tag: Int) {
        delegate?.didSelectCircle(withTag: tag)
    }
    @objc private func circleTapped(_ sender: UITapGestureRecognizer) {
        if let tag = sender.view?.tag {
            navigateToPage(withTag: tag)
        }
    }
}
protocol HomeViewDelegate: AnyObject {
    func didSelectCircle(withTag tag: Int)
}
