//
//  vaktija_watchApp.swift
//  vaktija-watch Watch App
//
//  Created by Mirza Kadric on 1. 6. 2025..
//

import SwiftUI

@main
struct vaktija_watch_Watch_AppApp: App {
    @StateObject var settings = SettingsManager();
    @StateObject var viewModel: VakatViewModel
    
    init(){
        let settingsManager = SettingsManager()
        _viewModel = StateObject(wrappedValue: VakatViewModel(settings: settingsManager))
    }
    
    var body: some Scene {
        WindowGroup {
            VakatView().environmentObject(settings).environmentObject(viewModel)
        }
    }
}
