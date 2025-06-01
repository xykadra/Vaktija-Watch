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
    private var settingsManager: SettingsManager
    
    init(settingsManager: SettingsManager){
        self.settingsManager = settingsManager
    
    }
    
    
    func fetchCities() {
        isLoading = true
        errorMessage = nil

        fetchCitiesUseCase.execute { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let cities):
                    self?.cities = cities
                    if let selectedID = self?.settingsManager.selectedCityIndex,
                       let selected = cities.first(where: { $0.id == selectedID }) {
                        self?.selectedCity = selected
                    }
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }

    func selectCity(_ city: City) {
         selectedCity = city
        settingsManager.selectedCityName = city.name
        settingsManager.selectedCityIndex = city.id
    }
}
