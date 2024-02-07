//
//  DiffableDataSourceViewController.swift
//  BookSearcher
//
//  Created by Кирилл Романенко on 07.02.2024.
//

import UIKit

class DiffableDataSourceViewController<Section: Hashable, Item: Hashable>: ViewController {
    typealias DataSource = UICollectionViewDiffableDataSource<Section, Item>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Item>

    internal var dataSource: DataSource?

    private(set) lazy var collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: .init())

    override func viewDidLoad() {
        super.viewDidLoad()

        configureCollectionView(collectionView: collectionView)
    }

    func configureCollectionView(collectionView: UICollectionView) {
        collectionView.dataSource = createDataSource(collectionView: collectionView)
        collectionView.collectionViewLayout = createCompositionalLayout()
    }

    func createDataSource(collectionView: UICollectionView) -> DataSource? {
        return nil
    }

    func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { _, _ in return nil }
    }
}
