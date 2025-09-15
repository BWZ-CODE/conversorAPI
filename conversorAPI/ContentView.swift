//
//  ContentView.swift
//  conversorAPI
//
//  Created by Miguel Angel Bohorquez on 3/08/25.
//

import SwiftUI




struct ContentView: View {
    @State private var valor1: String = ""
    @State private var valor2: String = ""
    @State private var valor3: String = ""

    
    
    var body: some View {
        NavigationStack{
            ZStack {
                Color.fondo.ignoresSafeArea(.all)
                VStack{
                  
                    Form{
                        HStack{
                            Image("colFlag").resizable().frame(width: 35, height: 20)
                            VStack(spacing:5){
                                Image(systemName: "dollarsign").resizable().frame(width: 20, height: 35).fontWeight(.bold)
                                Text("COP").font(.caption).opacity(0.5)
                            }
                            
                            TextField("", text: $valor1 ) .multilineTextAlignment(.trailing)
//                                .keyboardType(.decimalPad)
                                .onSubmit {
                                    print(valor1)
                                    Task {
                                            do {
                                                let response = try await ApiNetwork().getMoneyByQuery()
                                                
                                                if let USDRate = response.conversion_rates["USD"],
                                                   let eurRate = response.conversion_rates["EUR"] {
                                                    
                                                    if let valorIngresado = Double(valor1) {
                                                        valor2 = String(format: "%.2f",valorIngresado * eurRate)
                                                        valor3 = String(format: "%.2f",valorIngresado * USDRate)
                                                    }
                                                }
                                            } catch {
                                                print("Error al traer la API:", error)
                                            }
                                    }
                
                                    
                                }
                                
                        }

                        
                        HStack{
                            Image("ueFlag").resizable().frame(width: 35, height: 20)
                            VStack(spacing:5){
                                Image(systemName: "eurosign").resizable().frame(width: 20, height: 25).fontWeight(.bold)
                                Text("EUR").font(.caption).opacity(0.5)
                            }
                            
                            TextField("", text: $valor2 ) .multilineTextAlignment(.trailing)
//                                .keyboardType(.decimalPad)
                                .onSubmit {
                                    print(valor2)
                                    Task {
                                            do {
                                                let response = try await ApiNetwork().getMoneyByQuery()
                                                
                                                if let _ = response.conversion_rates["COP"],
                                                   let usdRate = response.conversion_rates["USD"],
                                                    let eurRate = response.conversion_rates["EUR"] {
                                                    
                                                    
                                                    if let valorIngresado = Double(valor2) {
                                                        valor1 = String(format: "%.2f",valorIngresado / eurRate)
                                                        valor3 = String(format: "%.2f",(valorIngresado * eurRate) / usdRate)
                                                    }
                                                }
                                            } catch {
                                                print("Error al traer la API:", error)
                                            }
                                    }
                
                                    
                                }
                            
                        }
                        HStack{
                            Image("usFlag").resizable().frame(width: 35, height: 70)
                            VStack(spacing:5){
                                Image(systemName: "dollarsign").resizable().frame(width: 20, height: 35).fontWeight(.bold)
                                Text("USD").font(.caption) .opacity(0.5)
                            }
                            
                            TextField("", text: $valor3 ) .multilineTextAlignment(.trailing)
//                                .keyboardType(.decimalPad)
                                .onSubmit {
                                    print(valor3)
                                    Task {
                                            do {
                                                let response = try await ApiNetwork().getMoneyByQuery()
                                                
                                                if let _ = response.conversion_rates["COP"],
                                                   let usdRate = response.conversion_rates["USD"],
                                                    let eurRate = response.conversion_rates["EUR"] {
                                                    
                                                    
                                                    if let valorIngresado = Double(valor3) {
                                                        valor1 = String(format: "%.2f", valorIngresado / usdRate)
                                                        valor2 = String(format: "%.2f",(valorIngresado * usdRate) / eurRate)
                                                    }
                                                }
                                            } catch {
                                                print("Error al traer la API:", error)
                                            }
                                    }
                
                                    
                                }
                            
                        }
                        
                        
                        
                    }.navigationTitle("")
                        .toolbar{
                            ToolbarItem(placement: .principal) {
                                Text("Tu conversor")
                                    .padding()
                                    .background(Color.azulClaro)
                                    .foregroundColor(Color.texto)
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .cornerRadius(20)
                                    
                                
                            }
                            
                        }
                        .scrollContentBackground(.hidden)
                    
                   
                }.background(Color.azulClaro.opacity(0.9))
                    .frame(height: 310)
                    .cornerRadius(20)
                
                .padding()
            }
        }
        
    }
}




#Preview {
    ContentView()
}
