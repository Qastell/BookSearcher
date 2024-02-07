//
//  CollectionView+.swift
//  BookSearcher
//
//  Created by Кирилл Романенко on 07.02.2024.
//

import UIKit

extension UICollectionView {
    func registerCell<T: UICollectionReusableView>(_ cell: T.Type) {
        register(cell, forCellWithReuseIdentifier: cell.classDescription)
    }

    func dequeue<T: UICollectionReusableView>(cell: T.Type, indexPath: IndexPath) -> T? {
        return dequeueReusableCell(withReuseIdentifier: T.classDescription, for: indexPath) as? T
    }
    
    func dequeue<T: UICollectionReusableView>(header: T.Type,
                                              kind: String = UICollectionView.elementKindSectionHeader,
                                              indexPath: IndexPath) -> T? {
        return  dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: T.classDescription,
            for: indexPath) as? T
    }
    
    func registerHeader<T: UICollectionReusableView>(_ header: T.Type) {
        register(header,
                 forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                 withReuseIdentifier: header.classDescription)
    }
}
