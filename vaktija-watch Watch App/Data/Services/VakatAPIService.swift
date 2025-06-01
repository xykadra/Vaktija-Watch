import Foundation

struct VakatDTO: Decodable {
    let lokacija: String
    let datum: [String]
    let vakat: [String]
}

class VakatAPIService {
    func fetchVakat(for cityIndex: Int, completion: @escaping (Result<VakatTime, Error>) -> Void) {
        let urlString = "https://api.vaktija.ba/vaktija/v1/\(cityIndex)"
        
        guard let url = URL(string: urlString) else {
            completion(.failure(URLError(.badURL)))
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(URLError(.badServerResponse)))
                return
            }

            do {
                let dto = try JSONDecoder().decode(VakatDTO.self, from: data)
                
                let vakat = VakatTime(
                    hijriDate: dto.datum[0],
                    gregorianDate: dto.datum[1],
                    vakats: dto.vakat,
                    location: dto.lokacija
                )

                completion(.success(vakat))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}

