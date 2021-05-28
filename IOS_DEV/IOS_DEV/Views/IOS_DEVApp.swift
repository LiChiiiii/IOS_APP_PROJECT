//
//  IOS_DEVApp.swift
//  IOS_DEV
//
//  Created by Jackson on 28/3/2021.
//

import SwiftUI

@main
struct IOS_DEVApp: App {
    @UIApplicationDelegateAdaptor(Appdelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
                WelcomePage()
        }
    }
}
