//
//  SectionHeaderView.swift
//  Cashly
//
//  Created by Nadirzada Alizaman on 05.10.25.
//

import UIKit

final class SectionHeaderView: UICollectionReusableView {
    let label: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 25, weight: .semibold)
        label.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(label)
        label.frame = bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
