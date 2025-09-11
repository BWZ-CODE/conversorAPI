//
//  apiNetwork.swift
//  conversorAPI
//
//  Created by Miguel Angel Bohorquez on 10/09/25.
//

import Foundation

class ApiNetwork{
    
    
    struct Envoltorio:Codable{
        let conversion_rates:[String: Double]
    }
     
    struct Monedas:Codable{
        let value:Double
    }
    
    func getMoneyByQuery () async throws-> Envoltorio{
        let apiURL = URL(string: "https://v6.exchangerate-api.com/v6/72dee02a361efc531d17810f/latest/COP")!
        
        
        let (data, _) = try await URLSession.shared.data(from: apiURL)
        
        let envoltorio = try JSONDecoder().decode(Envoltorio.self, from: data)
        return envoltorio
        
    }
}

//Se usa el codable cuando queramos traer esos datos del API, y se usa async porque ahi le estamos diciendo que vamos a traer los datos asincronamente, cuando el este listo, es para no saturar el celular o disp. El throws basicamente se usa para decirle que es posible que hayan errores al traer los datos

//El await se usa para disparar el async
