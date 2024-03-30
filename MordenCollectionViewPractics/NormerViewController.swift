//
//  NormerViewController.swift
//  MordenCollectionViewPractics
//
//  Created by Jae hyung Kim on 3/28/24.
//

import UIKit


class NormerViewController: UIViewController {
    typealias DataSource = UICollectionViewDiffableDataSource<Section, Item>

    private var bannerCellRegist: UICollectionView.CellRegistration<BannerCollectionViewCell, Item>? // 셀 등록
    private var caracellRegist: UICollectionView.CellRegistration<NormalCarosellColletionViewCell, Item>? // 셀 등록
    
    private var dataSource:DataSource? // 데이터 소스 등록
    
    let bannerItems = [
        Item.banner(HomeItem(text: "cas", imageUrl: "https://wimg.mk.co.kr/meet/neds/2022/10/image_readtop_2022_875926_16648812615186110.jpg")),
        Item.banner(HomeItem(text: "cas2", imageUrl: "https://wimg.mk.co.kr/meet/neds/2022/10/image_readtop_2022_875926_16648812615186110.jpg")),
        Item.banner(HomeItem(text: "cas3", imageUrl: "https://wimg.mk.co.kr/meet/neds/2022/10/image_readtop_2022_875926_16648812615186110.jpg")),
    ]
    
    let calousItems = [
        Item.normalCarousel(HomeItem(text: "카라셀", imageUrl: "https://cdn.pixabay.com/photo/2023/05/05/21/00/cute-7973191_1280.jpg", subtitle: "섭타이틀")),
        Item.normalCarousel(HomeItem(text: "카라셀2", imageUrl: "https://cdn.pixabay.com/photo/2023/05/05/21/00/cute-7973191_1280.jpg", subtitle: "섭타이틀")),
        Item.normalCarousel(HomeItem(text: "카라셀3", imageUrl: "https://cdn.pixabay.com/photo/2023/05/05/21/00/cute-7973191_1280.jpg", subtitle: "섭타이틀")),
        Item.normalCarousel(HomeItem(text: "카라셀4", imageUrl: "https://cdn.pixabay.com/photo/2023/05/05/21/00/cute-7973191_1280.jpg", subtitle: "섭타이틀")),
        Item.normalCarousel(HomeItem(text: "카라셀5", imageUrl: "https://cdn.pixabay.com/photo/2023/05/05/21/00/cute-7973191_1280.jpg", subtitle: "섭타이틀"))
    ]
    
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: .init())

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        cellRegistration()
        setUI()
        setDataSource()
        setSnapShot()
        
    }
    
    private func setDataSource(){
        // cellProvider -> 셀 주세요
        
        dataSource = DataSource(collectionView: collectionView, cellProvider: { [weak self] collectionView, indexPath, itemIdentifier in
            var cell = UICollectionViewCell.init()
            guard let weakSelf = self else { return cell }
            switch itemIdentifier {
            case .banner(_):
                guard let using = weakSelf.bannerCellRegist else { return cell}
                cell = collectionView.dequeueConfiguredReusableCell(using: using, for: indexPath, item: itemIdentifier)
            case .normalCarousel(_):
                guard let using = weakSelf.caracellRegist else { return cell}
                cell = collectionView.dequeueConfiguredReusableCell(using: using, for: indexPath, item: itemIdentifier)
            case .listCarousel(_):
                //guard let bannerCellRegist else { return .init()}
                break
            }
            return cell
        })
    }
    
    private func setSnapShot() {
        var snapShot = NSDiffableDataSourceSnapshot<Section, Item> ()
        print("setSnapShot")
        
        let normalSection = Section(id: "Test")
        
        snapShot.appendSections([normalSection])
        snapShot.appendItems(bannerItems, toSection: normalSection)
        
        
        let carousSection = Section(id: "Carosel")
        
        snapShot.appendSections([carousSection])
        snapShot.appendItems(calousItems,toSection: carousSection)
        
        dataSource?.apply(snapShot)
        print("setSnapShot ㄸㅇ")
    }
    
    

}

// MARK: 1. 셀 등록하기
extension NormerViewController {
    // 0. 레이아웃을 생성하기전 컬렉션뷰의 셀을 등록해 주어야 한다.
    private func cellRegistration(){
        // 1. 컬렉션뷰의 셀을 등록하기
        // collectionView.register(BannerCollectionViewCell.self , forCellWithReuseIdentifier: BannerCollectionViewCell.reusableIdentifier)
        
        // MARK: 배너 셀 레지스터
        bannerCellRegist = UICollectionView.CellRegistration<BannerCollectionViewCell, Item> {
             cell, indexPath, item  in
            if case .banner(let data) = item {
                print("bannerCellRegist")
                cell.config(title: data.text, imageUrl: data.imageUrl)
            }
            print(indexPath)
        }
        
        caracellRegist = UICollectionView.CellRegistration<NormalCarosellColletionViewCell, Item> { cell, indexPath, item in
            if case .normalCarousel(let item) = item {
                print("caracellRegist")
                cell.config(title: item.text, subTitle: item.subtitle, imageUrl: item.imageUrl)
            }
        }
    }
}

// MARK: 2. 레이아웃
extension NormerViewController {
    // 1. UI잡고, 레이아웃 잡고
    private func setUI(){
        view.addSubview(collectionView)
        collectionView.backgroundColor = .gray // OK
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        // 레이아웃을 바꾸어주자
        collectionView.collectionViewLayout = createLayout()
    }
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout(sectionProvider: { [weak self] sectionIndex, _ in
            print("createLayout")
            switch sectionIndex {
            case 0:
                return self?.createBannerSection()
            case 1:
                return self?.createCarouseSection()
            default : return self?.createBannerSection()
            }
        })
    }
    
    
    // item
    // group
    // section
    
    private func createBannerSection() -> NSCollectionLayoutSection {
        // item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let itemLayout = NSCollectionLayoutItem(layoutSize: itemSize)
        // group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(200))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [itemLayout])
        // section
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        return section
    }
    
    private func createCarouseSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.7), heightDimension: .absolute(180))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        
        section.orthogonalScrollingBehavior = .continuous
        return section
        
    }
}


// MARK: 집중
// 컬렉션뷰 cell UI - 등록
// dataSource -> cellProvider
// snapshot -> datasource.apply(snapshot)
