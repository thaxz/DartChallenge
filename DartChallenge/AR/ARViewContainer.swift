//
//  ARViewContainer.swift
//  DartChallenge
//
//  Created by thaxz on 02/10/23.
//

import Foundation
import SwiftUI
import ARKit

struct ARDartsViewContainer: UIViewControllerRepresentable {
    
    typealias UIViewControllerType = DartGameViewController

    func makeUIViewController(context: Context) -> DartGameViewController {
        let viewController = DartGameViewController()
        return viewController
    }

    func updateUIViewController(_ uiViewController: DartGameViewController, context: Context) {
    }
}



