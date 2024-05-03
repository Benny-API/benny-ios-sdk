//
//  Router.swift
//
//
//  Created by Ariel Bong on 4/29/24.
//

import Foundation
import SwiftUI

final class Router: ObservableObject {

    public enum Destination: Codable, Hashable {
        case enterCard
        case confirmPin
    }

    @Published var navPath = NavigationPath()

    func navigate(to destination: Destination) {
        navPath.append(destination)
    }

    func navigateBack() {
        navPath.removeLast()
    }

    func navigateToRoot() {
        navPath.removeLast(navPath.count)
    }
}
