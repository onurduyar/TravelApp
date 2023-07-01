//
//  PlaceDetailView.swift
//  TravelApp
//
//  Created by Onur Duyar on 1.07.2023.
//

import UIKit

class PlaceDetailView: UIView {
    weak var delegate: PlaceDetailVCDelegate?
    var addressTitle: String? {
        didSet {
            titleLabel.text = addressTitle
        }
    }
    
    var address: String? {
        didSet {
            addressLabel.text = address
        }
    }
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        return label
    }()
    
    private let addressLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 17)
        label.textAlignment = .center
        label.numberOfLines = 5
        return label
    }()
    
    private let showOnMapButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Show on Map", for: .normal)
        button.addTarget(self, action: #selector(showOnMapButtonTapped), for: .touchUpInside)
        button.layer.borderWidth = 1.0
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.cornerRadius = 15
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 26)
        let padding: CGFloat = 16.0
        button.contentEdgeInsets = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        return button
    }()
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(titleLabel)
        addSubview(addressLabel)
        addSubview(showOnMapButton)
        addSubview(imageView)
    }
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(16)
            make.centerX.equalToSuperview()
        }
        
        addressLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
        }
        
        
        imageView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.top.equalTo(addressLabel.snp.bottom).offset(16)
            make.height.equalTo(400)
        }
        showOnMapButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(imageView.snp.bottom).offset(40)
        }
        
    }
    
    @objc private func showOnMapButtonTapped() {
        delegate?.showOnMapButtonTapped()
    }
}

protocol PlaceDetailVCDelegate: AnyObject {
    func showOnMapButtonTapped()
}
