//
//  SelectCityViewModel.swift
//  vaktija-watch
//
//  Created by Mirza Kadric on 1. 6. 2025..
//

import SwiftUI

class SelectCityViewModel: ObservableObject {
    @Published var cities: [City] = []
    @Published var selectedCity: City?
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let fetchCitiesUseCase = FetchCitiesUseCase()

    func fetchCities() {
        isLoading = true
        errorMessage = nil

        fetchCitiesUseCase.execute { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let cities):
                    self?.cities = cities
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }

    func selectCity(_ city: City) {
        selectedCity = city
        // Save to UserDefaults, send back to parent view, etc.
    }
}
