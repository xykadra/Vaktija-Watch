//
//  FetchVakatUseCase.swift
//  vaktija-watch Watch App
//
//  Created by Mirza Kadric on 1. 6. 2025..
//

import Foundation

protocol FetchVakatUseCase {
    func execute(completion: @escaping (Result<VakatTime, Error>) -> Void)
}
