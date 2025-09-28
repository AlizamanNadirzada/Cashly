//
//  TabBarCoordinator.swift
//  Cashly
//
//  Created by Nadirzada Alizaman on 01.09.25.
//

import UIKit

final class TabBarCoordinator: Coordinator {
    var children: [Coordinator] = []
    var window: UIWindow

    init(window: UIWindow) {
        self.window = window
    }

    func start() {
        
    }
}
