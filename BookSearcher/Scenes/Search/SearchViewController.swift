//
//  SearchViewController.swift
//  BookSearcher
//
//  Created by Кирилл Романенко on 07.02.2024.
//

import UIKit
import Stevia

@MainActor
protocol SearchViewControllerProtocol: AnyObject {
    func applySnapshot(section: SearchSection?, animated: Bool)
}

final class SearchViewController: DiffableDataSourceViewController<SearchSection, SearchCellModel> {
    
    var presenter: SearchPresenterProtocol?
    
    // MARK: - UI
    
    private let searchTextField: TextField = {
        let view = TextField()
        view.backgroundColor = App.colors.backgroundSecondary
        view.cornerRadius = 10
        view.clipsToBounds = true
        view.textInsets.left = 16
        view.textInsets.right = 16
        view.tintColor = App.colors.textPrimary
        view.textColor = App.colors.textPrimary
        view.font = App.fonts.regular(of: 16)
        view.placeholder = App.strings.searchBooksPlaceholder
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func setupUI() {
        searchTextField.didChangeText { [weak self] textField in
            self?.presenter?.didChangeSearchText(textField.text)
        }
        
        view.backgroundColor = App.colors.background
        
        view.subviews(
            collectionView,
            searchTextField
        )
        
        searchTextField
            .height(40)
            .fillHorizontally(padding: 10)
            .Top == view.safeAreaLayoutGuide.Top

        collectionView
            .bottom(0)
            .fillHorizontally()
            .Top == view.safeAreaLayoutGuide.Top
    }

    override func configureCollectionView(collectionView: UICollectionView) {
        super.configureCollectionView(collectionView: collectionView)

        collectionView.registerCell(SearchCell.self)
        collectionView.registerHeader(SearchSectionHeaderView.self)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.contentInset.top = 50
    }

    override func createDataSource(collectionView: UICollectionView) -> DataSource? {
        dataSource = DataSource(collectionView: collectionView) { collectionView, indexPath, cellModel -> UICollectionViewCell? in
            let cell = collectionView.dequeue(cell: SearchCell.self, indexPath: indexPath)
            cell?.configure(with: cellModel)
            return cell
        }
        dataSource?.supplementaryViewProvider = { [weak self] collectionView, kind, indexPath in
            guard let sectionKind = self?.dataSource?.sectionIdentifier(for: indexPath.section)?.kind else {
                return nil
            }

            switch sectionKind {
            case .loaded:
                return nil
            case .stored:
                return collectionView.dequeue(header: SearchSectionHeaderView.self,
                                              kind: kind,
                                              indexPath: indexPath)
            }
        }
        return dataSource
    }

    override func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { [weak self] sectionIndex, _ in
            guard let self else { return nil }
            
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .absolute(60)
            )

            let itemLayout = NSCollectionLayoutItem(layoutSize: itemSize)
            let groupLayout = NSCollectionLayoutGroup.vertical(
                layoutSize: itemSize,
                subitems: [itemLayout]
            )
            let sectionLayout = NSCollectionLayoutSection(group: groupLayout)
            
            if let sectionKind = dataSource?.sectionIdentifier(for: sectionIndex)?.kind,
               sectionKind == .stored {
                sectionLayout.boundarySupplementaryItems = [createHeaderLayout()]
            }

            return sectionLayout
        }
    }
}

// MARK: - UICollectionViewDelegate

extension SearchViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.didSelectItem(at: indexPath)
    }
}

// MARK: - SearchViewControllerProtocol

extension SearchViewController: SearchViewControllerProtocol {
    func applySnapshot(section: SearchSection?, animated: Bool) {
        var snapshot = Snapshot()
        if let section {
            snapshot.appendSections([section])
            snapshot.appendItems(section.items, toSection: section)
        }
        dataSource?.apply(snapshot, animatingDifferences: animated)
    }
}

// MARK: - Private

private extension SearchViewController {
    func createHeaderLayout() -> NSCollectionLayoutBoundarySupplementaryItem {
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                heightDimension: .estimated(30))
        return NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
                                                           elementKind: UICollectionView.elementKindSectionHeader,
                                                           alignment: .top)
    }
}

