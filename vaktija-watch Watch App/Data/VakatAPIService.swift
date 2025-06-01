//
//  VakatAPIService.swift
//  vaktija-watch
//
//  Created by Mirza Kadric on 1. 6. 2025..
//

import Foundation

struct VakatDTO: Decodable {
    let lokacija: String
    let datum: [String]
    let vakat: [String]
}

class VakatAPIService {
    func fetchVakat(completion: @escaping (Result<VakatTime, Error>) -> Void) {
        guard let url = URL(string: "https://api.vaktija.ba") else {
            completion(.failure(URLError(.badURL)))
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data,
                  let dto = try? JSONDecoder().decode(VakatDTO.self, from: data) else {
                completion(.failure(URLError(.cannotDecodeContentData)))
                return
            }

            let vakat = VakatTime(
                hijriDate: dto.datum[0],
                gregorianDate: dto.datum[1],
                vakats: dto.vakat,
                location: dto.lokacija
            )

            completion(.success(vakat))
        }.resume()
    }
}
