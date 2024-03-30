//
//  BanerCollectionViewCell.swift
//  MordenCollectionViewPractics
//
//  Created by Jae hyung Kim on 3/28/24.
//

import UIKit
import SnapKit
import Kingfisher

class BannerCollectionViewCell: UICollectionViewCell {
    
    let titleLabel = UILabel()
    let backgroundInage = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        designView()
    }
    
    private func setUI(){
        contentView.addSubview(backgroundInage)
        contentView.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        backgroundInage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
  
    func config(title: String, imageUrl: String){
        titleLabel.text = title
        let url = URL(string: imageUrl)
        backgroundInage.kf.setImage(with: url)
    }
    func designView(){
        titleLabel.font = .systemFont(ofSize: 30, weight: .heavy)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

