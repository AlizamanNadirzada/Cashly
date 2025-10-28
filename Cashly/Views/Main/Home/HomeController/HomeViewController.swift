//
//  HomeViewController.swift
//  Cashly
//
//  Created by Nadirzada Alizaman on 30.08.25.
//

import UIKit

final class HomeViewController: BaseViewController {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Cashly - Money Manager"
        label.textColor = .label
        label.font = .systemFont(ofSize: 25, weight: .semibold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Easy tracking, smart analysis, more savings."
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 17, weight: .regular)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let collection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.isScrollEnabled = false
        collection.register(ActionCell.self, forCellWithReuseIdentifier: ActionCell.reuseIdentifier)
        collection.register(CardCell.self, forCellWithReuseIdentifier: CardCell.reuseIdentifier)
        collection.register(OperationCell.self, forCellWithReuseIdentifier: OperationCell.reuseIdentifier)
        collection.register(
            SectionHeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: SectionHeaderView.reuseIdentifier
        )
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    private let pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.currentPage = 0
        pc.pageIndicatorTintColor = UIColor.tertiaryLabel
        pc.currentPageIndicatorTintColor = .systemGreen
        pc.translatesAutoresizingMaskIntoConstraints = false
        return pc
    }()
    
    //    MARK: - Properties
    private var collectionLayout = CollectionLayout()
    private var collectionDataSource: UICollectionViewDiffableDataSource<HomeSection, HomeItem>!
    private let viewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createLayout()
        configureDataSource()
        applySnapshot()
        viewModel.loadInitialData()
    }
    
    override func configureUI() {
        view.addSubviews(titleLabel, subtitleLabel, collection)
        collection.addSubview(pageControl)
    }
    
    override func configureConstraints() {
        NSLayoutConstraint.activate([
            // Title
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            // Subtitle
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 6),
            subtitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            // Collection View
            collection.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 12),
            collection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collection.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collection.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            // Page Controller
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pageControl.topAnchor.constraint(equalTo: collection.topAnchor, constant: 266)
        ])
    }
}

extension HomeViewController {
    private func createLayout() {
        let layout = UICollectionViewCompositionalLayout {
            [weak self] sectionIndex, environment in
            guard let self else { return nil }
            guard let section = self
                .collectionDataSource
                .sectionIdentifier(for: sectionIndex) else { return nil }
            switch section {
            case .cards:
                return collectionLayout.cardSection()
            case .actions:
                return collectionLayout.actionSection()
            case .operations:
                return collectionLayout.operationSection()
            }
        }
        
        collection.setCollectionViewLayout(layout, animated: false)
    }
    
    private func configureDataSource() {
        collectionDataSource = UICollectionViewDiffableDataSource<HomeSection, HomeItem>(collectionView: collection) { collectionView, indexPath, item in
            switch item {
                case .card(let card):
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardCell.reuseIdentifier, for: indexPath) as! CardCell
                    cell.configureData(with: card)
                    return cell
                case .action(let model):
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ActionCell.reuseIdentifier, for: indexPath) as! ActionCell
                
                    cell.configureData(model: model) { [weak self] in
                        guard let self else { return }
                        switch model.type {
                        case .add:
                            viewModel.addRandomCard()
                        case .delete:
                            viewModel.deleteCard(at: 0)
                        case .transfer:
                            showTransferScreen()
                        }
                    }
                    return cell
                case .operation(let model):
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OperationCell.reuseIdentifier, for: indexPath) as! OperationCell
                    cell.configureData(model: model)
                    return cell
            }
        }
        
        collectionDataSource.supplementaryViewProvider = { collectionView, kind, indexPath in
            guard kind == UICollectionView.elementKindSectionHeader else { return nil }
            guard let section = self.collectionDataSource.sectionIdentifier(for: indexPath.section) else { return nil }
            
            let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: SectionHeaderView.reuseIdentifier,
                for: indexPath
            ) as! SectionHeaderView
            
            switch section {
            case .cards:
                header.label.text = "Cards"
            case .actions:
                return nil
            case .operations:
                header.label.text = "Operations"
            }
            
            return header
        }
    }
    
    private func applySnapshot() {
        viewModel.onSnapshotUpdate = { [weak self] data in
            guard let self else { return }
            
            var snapshot = NSDiffableDataSourceSnapshot<HomeSection, HomeItem>()
            snapshot.appendSections([.cards, .actions, .operations])
            snapshot.appendItems(data[.cards] ?? [], toSection: .cards)
            snapshot.appendItems(data[.actions] ?? [], toSection: .actions)
            snapshot.appendItems(data[.operations] ?? [], toSection: .operations)
            
            self.collectionDataSource.apply(snapshot, animatingDifferences: true)
            self.pageControl.numberOfPages = data[.cards]?.count ?? 0
        }
    }
}

extension HomeViewController {
    private func showTransferScreen() {
        let controller = TransferViewController()
        navigationController?.pushViewController(controller, animated: true)
    }
}
