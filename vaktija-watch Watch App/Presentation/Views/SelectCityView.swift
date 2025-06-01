import SwiftUI

struct SelectCityView: View {
    @StateObject private var viewModel = SelectCityViewModel()

    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView("Loading Cities...")
            } else if let error = viewModel.errorMessage {
                Text(error).foregroundColor(.red)
            } else {
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

