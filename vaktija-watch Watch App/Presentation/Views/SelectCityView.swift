import SwiftUI

struct SelectCityView: View {
    @EnvironmentObject var settingsManager: SettingsManager
    @StateObject private var viewModel: SelectCityViewModel
    @EnvironmentObject var vakatViewMode: VakatViewModel

    init(settingsManager: SettingsManager) {
          _viewModel = StateObject(wrappedValue: SelectCityViewModel(settingsManager: settingsManager))
      }
    
    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView()
            } else if let error = viewModel.errorMessage {
                Text(error).foregroundColor(.red)
            } else {
                ScrollViewReader{
                    proxy in
                    List(viewModel.cities) { city in
                        Button {
                            viewModel.selectCity(city)
                           
                        } label: {
                            HStack {
                                Text(city.name)
                                Spacer()
                                if viewModel.selectedCity?.id == city.id {
                                    Image(systemName: "checkmark")
                                        .foregroundColor(.blue)
                                }
                            }
                        }.id(city.id)
                        
                    }

                }
                
               
            }
        }
        .navigationTitle("Odaberi grad")
        .onAppear {
            viewModel.fetchCities()
        }
    }
}

