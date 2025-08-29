//
//  BaseViewController.swift
//  Cashly
//
//  Created by Nadirzada Alizaman on 24.08.25.
//

import UIKit

class BaseViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        configureUI()
        configureConstraints()
        configureActions()
    }
    
    open func configureUI() {}
    
    open func configureConstraints() {}
    
    open func configureActions() {}
}
