//
//  DetailCell.swift
//  TravelApp
//
//  Created by Onur Duyar on 27.06.2023.
//

import UIKit

class DetailCell: UITableViewCell {
    private let padding: CGFloat = 10.0
    private let interCellSpacing: CGFloat = 10.0
    
    var detailText:String?{
        didSet{
            detailTitleLabel.text = detailText
        }
    }
    
    var image: UIImage? {
        didSet {
            detailImageView.image = image
        }
    }
    
    let detailTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 5
        label.font = UIFont.boldSystemFont(ofSize: 12)
        return label
    }()
    
    private(set) lazy var detailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 10.0
        imageView.clipsToBounds = true
       
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    private func setupViews() {
        contentView.layer.cornerRadius = 25
        contentView.layer.masksToBounds = true
        contentView.layer.borderWidth = 1.0
        contentView.layer.borderColor = UIColor.black.cgColor
        
        let imageViewContainer = UIView()
        contentView.addSubview(imageViewContainer)
        imageViewContainer.layer.cornerRadius = 10.0
        imageViewContainer.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.left.equalTo(contentView).offset(padding)
            make.width.equalTo(contentView.snp.width).multipliedBy(0.5)
            make.top.equalTo(contentView).offset(padding)
            make.bottom.equalTo(contentView).offset(-padding)
        }
        
        imageViewContainer.addSubview(detailImageView)
        detailImageView.snp.makeConstraints { make in
            make.center.equalTo(imageViewContainer)
            make.width.height.equalTo(100)
        }
        
        let titleContainer = UIView()
        contentView.addSubview(titleContainer)
        titleContainer.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(padding)
            make.width.equalTo(contentView.snp.width).multipliedBy(0.25)
            make.right.equalTo(contentView).offset(-padding)
            make.bottom.lessThanOrEqualTo(contentView).offset(-padding)
        }
        
        titleContainer.addSubview(detailTitleLabel)
        detailTitleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(titleContainer)
            make.left.right.equalTo(titleContainer)
        }
    }

    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: interCellSpacing, left: interCellSpacing, bottom: interCellSpacing, right: interCellSpacing))
    }
}

