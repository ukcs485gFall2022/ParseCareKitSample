//
//  InsightsView.swift
//  OCKSample
//
//  Created by Corey Baker on 12/5/22.
//  Copyright © 2022 Network Reconnaissance Lab. All rights reserved.
//

import SwiftUI

struct InsightsView: UIViewControllerRepresentable {
    @State var storeManager = StoreManagerKey.defaultValue

    func makeUIViewController(context: Context) -> some UIViewController {
        let viewController = CareViewController(storeManager: storeManager)
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.navigationBar.backgroundColor = UIColor { $0.userInterfaceStyle == .light ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1): #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1) }
        return navigationController
    }

    func updateUIViewController(_ uiViewController: UIViewControllerType,
                                context: Context) {}
}

struct InsightsView_Previews: PreviewProvider {
    static var previews: some View {
        InsightsView()
    }
}
