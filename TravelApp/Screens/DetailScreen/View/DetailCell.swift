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
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    private(set) lazy var detailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 10.0
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
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
        
        contentView.addSubview(detailTitleLabel)
        detailTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(padding)
            make.right.left.equalTo(contentView).offset(padding)
        }
        
        contentView.addSubview(detailImageView)
        detailImageView.snp.makeConstraints { make in
            make.top.equalTo(detailTitleLabel.snp.bottom).offset(padding)
            make.right.left.equalTo(contentView).offset(padding)
            make.height.equalTo(80)
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

