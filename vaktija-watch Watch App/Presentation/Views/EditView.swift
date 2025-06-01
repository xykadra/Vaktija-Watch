//
//  EditView.swift
//  vaktija-watch Watch App
//
//  Created by Mirza Kadric on 1. 6. 2025..
//

import SwiftUI

struct EditView: View {
    @EnvironmentObject var settings: SettingsManager
    
    var body: some View {
        VStack{
            Form{
                Section{
                    NavigationLink(destination: SelectCityView(settingsManager: settings)){
                        VStack(alignment: .leading) {
                            Text("Grad")
                            Text(settings.selectedCityName)
                                .foregroundColor(.gray)
                        }
                    }
                                    
                    
                }
                Section{
                    NavigationLink(destination: NotificationSettingsView()){
                        VStack(alignment: .leading){
                            Text("Notifikacije")
                            if(settings.notificationsEnabled){
                                Text("\(settings.minutesBeforeNotification) minuta prije")
                                   .foregroundColor(.gray)
                            }
                            else{
                                Text("Isključeno")
                                   .foregroundColor(.gray)
                            }

                            
                        }
                    }
                    
                    
                }
            }.listSectionSpacing(8)
        }.navigationTitle("Uredi")
    }
}
