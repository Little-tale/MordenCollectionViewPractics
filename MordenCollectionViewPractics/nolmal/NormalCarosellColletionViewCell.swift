//
//  NomalCarosellColletionViewCell.swift
//  MordenCollectionViewPractics
//
//  Created by Jae hyung Kim on 3/30/24.
//

import UIKit
import SnapKit
import Kingfisher

class NormalCarosellColletionViewCell: UICollectionViewCell {
    
    private let mainImage = UIImageView()
    private let titleLabel = UILabel()
    private let subTitleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    private func setUI(){
        contentView.backgroundColor = .white
        
        contentView.addSubview(mainImage)
        contentView.addSubview(titleLabel)
        contentView.addSubview(subTitleLabel)
        
        mainImage.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
            make.height.equalTo(100)
        }
        titleLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.equalTo(mainImage.snp.bottom).offset(8)
        }
        subTitleLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
        }
    }
    
    func config(title: String, subTitle: String?, imageUrl: String) {
        print(#function)
        titleLabel.text = title
        subTitleLabel.text = subTitle
        mainImage.kf.setImage(with: URL(string: imageUrl))
        
    }
    
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

