//
//  FetchCitiesUseCase.swift
//  vaktija-watch
//
//  Created by Mirza Kadric on 1. 6. 2025..
//

class FetchCitiesUseCase {
    private let service: LocationAPIService

    init(service: LocationAPIService = LocationAPIService()) {
        self.service = service
    }

    func execute(completion: @escaping (Result<[City], Error>) -> Void) {
        service.fetchCities { result in
            switch result {
            case .success(let cityDTOs):
                let cities = cityDTOs.map { City(id: $0.id, name: $0.name) }
                completion(.success(cities))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
