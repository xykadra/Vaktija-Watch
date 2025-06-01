//
//  LocationAPIService.swift
//  vaktija-watch
//
//  Created by Mirza Kadric on 1. 6. 2025..
//

import Foundation


class LocationAPIService {
    func fetchCities(completion: @escaping (Result<[CityDTO], Error>) -> Void) {
       
            guard let url = URL(string: "https://api.vaktija.ba/vaktija/v1/lokacije") else {
                completion(.failure(URLError(.badURL)))
                return
            }

            URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }

                guard let data = data else {
                    completion(.failure(URLError(.badServerResponse)))
                    return
                }

                do {
                    let names = try JSONDecoder().decode([String].self, from: data)
                    let cityDTOs = names.enumerated().map { index, name in
                        CityDTO(id: index, name: name)
                    }
                    completion(.success(cityDTOs))
                } catch {
                    completion(.failure(error))
                }
            }.resume()
        }
}
