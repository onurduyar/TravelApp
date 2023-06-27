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
    lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()
    
    let circleInfo: [(imageName: String, labelText: String)] = [("hostel_icon", "Hotels"), ("restaurant_icon", "Restaurants"), ("attraction_icon", "Attractions")]
    
    let transportationInfo: [(imageName: String, labelText: String)] = [("airport_icon", "Airport"), ("trainstation_icon", "Train Station")]

    let shoppingInfo: [(imageName: String, labelText: String)] = [("shoppingmall_icon", "Shopping Mall"), ("supermarket_icon", "Supermarket")]
    
    private var circleViews: [UIView] = []
    private var circleTextLabels: [UILabel] = []
    private var circleImageViews: [UIImageView] = []
    
    private var transportationRectangleViews: [UIView] = []
    private var transportationRectangleTextLabels: [UILabel] = []
    private var transportationRectangleImageViews: [UIImageView] = []
    
    private var shoppingRectangleViews: [UIView] = []
    private var shoppingRectangleTextLabels: [UILabel] = []
    private var shoppingRectangleImageViews: [UIImageView] = []
    
    private lazy var travelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        return stackView
    }()
    private lazy var transportationStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 5
        return stackView
    }()
    private lazy var transportationTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24,weight: .bold)
        label.text = "Transportation"
        return label
    }()
    
    private lazy var shoppingStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 5
        return stackView
    }()
    private lazy var shoppingTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24,weight: .bold)
        label.text = "Shopping"
        return label
    }()
    
    init(cardView: CardView) {
        self.cardViewHostController = UIHostingController(rootView: cardView)
        super.init(frame: .zero)
        
        backgroundColor = .white
        self.addSubview(activityIndicator)
        self.activityIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        setupConstraints()
        
        
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
        
        addSubview(travelStackView)
        travelStackView.snp.makeConstraints { make in
            make.top.equalTo(cardViewHostController.view.snp.bottom).offset(50)
            make.left.right.equalToSuperview()
            make.height.equalTo(80)
        }
        
        
        DispatchQueue.main.async {
            self.addSubview(self.transportationTextLabel)
            self.transportationTextLabel.snp.makeConstraints { make in
                make.top.equalTo(self.travelStackView.snp.bottom).offset(40)
                make.left.equalToSuperview().offset(10)
            }
            
            self.addSubview(self.transportationStackView)
            self.transportationStackView.snp.makeConstraints { make in
                make.top.equalTo(self.transportationTextLabel.snp.bottom).offset(5)
                make.left.right.equalToSuperview()
                make.height.equalTo(80)
            }
            
            self.addSubview(self.shoppingTextLabel)
            self.shoppingTextLabel.snp.makeConstraints { make in
                make.top.equalTo(self.transportationStackView.snp.bottom).offset(40)
                make.left.equalToSuperview().offset(10)
            }
            self.addSubview(self.shoppingStackView)
            self.shoppingStackView.snp.makeConstraints { make in
                make.top.equalTo(self.shoppingTextLabel.snp.bottom).offset(5)
                make.left.right.equalToSuperview()
                make.height.equalTo(80)
            }
            
        }
        
        self.setupCircleView()
        self.setupTransportationRectangleViews()
        self.setupShoppingRectangleViews()
    }
    private func setupCircleView() {
        DispatchQueue.main.async {
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
                self.travelStackView.addArrangedSubview(circleView)
                let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.circleTapped(_:)))
                circleView.addGestureRecognizer(tapGesture)
                circleView.isUserInteractionEnabled = true
                circleView.tag = info.offset
            }
        }
    }
    private func setupTransportationRectangleViews(){
        
        DispatchQueue.main.async {
            
            for info in self.transportationInfo.enumerated() {
                let rectangleView = UIView()
                rectangleView.backgroundColor = .clear
                rectangleView.layer.cornerRadius = 30
                
                
                let imageView = UIImageView(image: UIImage(named: info.element.imageName))
                imageView.contentMode = .scaleAspectFit
                
                let label = UILabel()
                label.text = info.element.labelText
                label.font = UIFont.systemFont(ofSize: 12)
                label.textAlignment = .center
                label.textColor = .black
                
                rectangleView.addSubview(imageView)
                rectangleView.addSubview(label)
                
                imageView.snp.makeConstraints { make in
                    make.center.equalToSuperview()
                    make.width.height.equalTo(80)
                }
                
                label.snp.makeConstraints { make in
                    make.top.equalTo(imageView.snp.bottom).offset(5)
                    make.centerX.equalToSuperview()
                }
                self.transportationRectangleViews.append(rectangleView)
                self.transportationRectangleImageViews.append(imageView)
                self.transportationRectangleTextLabels.append(label)
                self.transportationStackView.addArrangedSubview(rectangleView)
                
                let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.transportationRectangleTapped(_:)))
                rectangleView.addGestureRecognizer(tapGesture)
                rectangleView.isUserInteractionEnabled = true
                rectangleView.tag = info.offset
            }
        }
        
    }
    private func setupShoppingRectangleViews(){
        
        DispatchQueue.main.async {
            
            for info in self.shoppingInfo.enumerated() {
                let rectangleView = UIView()
                rectangleView.backgroundColor = .clear
                rectangleView.layer.cornerRadius = 30
                
                
                let imageView = UIImageView(image: UIImage(named: info.element.imageName))
                imageView.contentMode = .scaleAspectFit
                
                let label = UILabel()
                label.text = info.element.labelText
                label.font = UIFont.systemFont(ofSize: 12)
                label.textAlignment = .center
                label.textColor = .black
                
                rectangleView.addSubview(imageView)
                rectangleView.addSubview(label)
                
                imageView.snp.makeConstraints { make in
                    make.center.equalToSuperview()
                    make.width.height.equalTo(80)
                }
                
                label.snp.makeConstraints { make in
                    make.top.equalTo(imageView.snp.bottom).offset(5)
                    make.centerX.equalToSuperview()
                }
                self.shoppingRectangleViews.append(rectangleView)
                self.shoppingRectangleImageViews.append(imageView)
                self.shoppingRectangleTextLabels.append(label)
                self.shoppingStackView.addArrangedSubview(rectangleView)
                
                let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.shoppingRectangleTapped(_:)))
                rectangleView.addGestureRecognizer(tapGesture)
                rectangleView.isUserInteractionEnabled = true
                rectangleView.tag = info.offset
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
    @objc private func transportationRectangleTapped(_ sender: UITapGestureRecognizer) {
        if let tag = sender.view?.tag {
            delegate?.didSelectTransportationRectangle(withTag: tag)
        }
    }
    @objc private func shoppingRectangleTapped(_ sender: UITapGestureRecognizer) {
        if let tag = sender.view?.tag {
            delegate?.didSelectShoppingRectangle(withTag: tag)
        }
    }
}
protocol HomeViewDelegate: AnyObject {
    func didSelectCircle(withTag tag: Int)
    func didSelectTransportationRectangle(withTag tag: Int)
    func didSelectShoppingRectangle(withTag tag: Int)
}
