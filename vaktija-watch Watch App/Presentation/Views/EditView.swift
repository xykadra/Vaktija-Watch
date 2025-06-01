//
//  EditView.swift
//  vaktija-watch Watch App
//
//  Created by Mirza Kadric on 1. 6. 2025..
//

import SwiftUI

struct EditView: View {
    @StateObject private var viewModel = VakatViewModel()
    var body: some View {
        VStack{
            Form{
                Section{
                    NavigationLink(destination: SelectCityView()){
                        VStack(alignment: .leading) {
                            Text("Grad")
                            Text(viewModel.vakatTime?.location ?? "Vaktija")
                                .foregroundColor(.gray)
                        }
                    }
                    
                    
                    
                }
                Section{
                    NavigationLink(destination: NotificationSettingsView()){
                        VStack(alignment: .leading){
                            Text("Notifikacije")
                            Text("10 min prije.").foregroundColor(.gray)
                            
                        }
                    }
                    
                    
                }
            }.listSectionSpacing(8)
        }.navigationTitle("Uredi")
    }
}
