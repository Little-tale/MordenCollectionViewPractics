//
//  Item.swift
//  MordenCollectionViewPractics
//
//  Created by Jae hyung Kim on 3/28/24.
//

import Foundation

// 섹션
struct Section: Hashable {
    let id: String
}
// 아이템
enum Item: Hashable {
    case banner(HomeItem)
    case normalCarousel(HomeItem)
    case listCarousel(HomeItem)
}
// 모델
struct HomeItem: Hashable {
    let text: String
    let subtitle: String?
    let imageUrl: String
    let id = UUID()
    
    init(text: String, imageUrl: String, subtitle: String? = "") {
        self.text = text
        self.imageUrl = imageUrl
        self.subtitle = subtitle
    }
}
