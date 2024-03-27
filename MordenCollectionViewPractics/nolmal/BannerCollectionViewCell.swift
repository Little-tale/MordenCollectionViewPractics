//
//  BanerCollectionViewCell.swift
//  MordenCollectionViewPractics
//
//  Created by Jae hyung Kim on 3/28/24.
//

import UIKit
import SnapKit

class BannerCollectionViewCell: UICollectionViewCell {
    
    let titleLabel = UILabel()
    let backgroundInage = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setUI(){
        contentView.addSubview(titleLabel)
        contentView.addSubview(backgroundInage)
        
        titleLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        backgroundInage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
  
    private func config(title: String, imageUrl: String){
        
    }
    
}

