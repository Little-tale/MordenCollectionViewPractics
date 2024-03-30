//
//  NormerViewController.swift
//  MordenCollectionViewPractics
//
//  Created by Jae hyung Kim on 3/28/24.
//

import UIKit

class NormerViewController: UIViewController {
    typealias DataSource = UICollectionViewDiffableDataSource<Section, Item>
    typealias CellRegiste = UICollectionView.CellRegistration<BannerCollectionViewCell, Item>
    
    private var cellRegistraition: CellRegiste? // 셀 등록
    private var dataSource:DataSource? // 데이터 소스 등록
    
    let bannerItems = [
        Item.banner(HomeItem(text: "cas", imageUrl: "https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.pinterest.com%2Fpin%2F854698835528050820%2F&psig=AOvVaw0h5clqmOW5MJ4a4OJoD3C6&ust=1711649454952000&source=images&cd=vfe&opi=89978449&ved=0CBIQjRxqFwoTCJiv5Z-FlYUDFQAAAAAdAAAAABAE")),
        Item.banner(HomeItem(text: "cas2", imageUrl: "https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.pinterest.com%2Fpin%2F854698835528050820%2F&psig=AOvVaw0h5clqmOW5MJ4a4OJoD3C6&ust=1711649454952000&source=images&cd=vfe&opi=89978449&ved=0CBIQjRxqFwoTCJiv5Z-FlYUDFQAAAAAdAAAAABAE")),
        Item.banner(HomeItem(text: "cas3", imageUrl: "https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.pinterest.com%2Fpin%2F854698835528050820%2F&psig=AOvVaw0h5clqmOW5MJ4a4OJoD3C6&ust=1711649454952000&source=images&cd=vfe&opi=89978449&ved=0CBIQjRxqFwoTCJiv5Z-FlYUDFQAAAAAdAAAAABAE")),
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
        guard let cellRegistraition else { return }
        
        dataSource = DataSource(collectionView: collectionView, cellProvider: { [weak self] collectionView, indexPath, itemIdentifier in
            guard let self else {
                print("데이터 소스 실패 ")
                return UICollectionViewCell()
            }
            print("데이터 소스")
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistraition, for: indexPath, item: itemIdentifier)
            return cell
        })
    }
    
    private func setSnapShot() {
        var snapShot = NSDiffableDataSourceSnapshot<Section, Item> ()
        print("setSnapShot")
        snapShot.appendSections([Section(id: "Test")])

        snapShot.appendItems(bannerItems, toSection: Section(id: "Test"))
        
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
        let cellRefgistration = CellRegiste {
            ( cell,  indexPath, item ) in
            switch item {
            case .banner(let data):
                cell.titleLabel.text = data.text
            case .normalCarousel(_):
                break
            case .listCarousel(_):
                break
            }
            print(indexPath)
        }
        print(" cellRefgistration 성공 실패 모르는 구역")
        cellRegistraition = cellRefgistration
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
        return UICollectionViewCompositionalLayout(sectionProvider: { [weak self] sectionIndex, environment in
            print("createLayout")
            return self?.createBannerSection()
        })
    }
    
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
}


// MARK: 집중
// 컬렉션뷰 cell UI - 등록
// dataSource -> cellProvider
// snapshot -> datasource.apply(snapshot)
