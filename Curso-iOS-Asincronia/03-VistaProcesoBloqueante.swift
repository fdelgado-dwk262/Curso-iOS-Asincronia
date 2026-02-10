//
//  VistaProcesoBloqueante.swift
//  Curso-iOS-Asincronia
//
//  Created by Equipo 9 on 10/2/26.
//

import SwiftUI

struct VistaProcesoBloqueante: View {
    
    @State private var resultado = "--"
    @State private var estaCalculando = false
    
    var  body: some View {
        
        VStack(spacing: 20) {
            Text("Ventana de calculos: ")
                .font(.title)

            
            if estaCalculando {
                ProgressView("Procesando calculos")
                    .controlSize(.large)
                    .tint(.blue)
            }

            Text(resultado)
                .font(.headline)
            
            Button("Calcular (bloqueado)") {
                estaCalculando = true
                
                // Ejecuta la función en el main Thread y
                // lo va a bloquear
                let resultadoCalculo = calculoPesado()
                
                estaCalculando = false
                
                resultado = "Calculado : \(resultadoCalculo)"
                
            }
            .padding(10)
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)
            
            
            Button("Calcular con Task") {
                Task {
                    estaCalculando = true
                    
                    // como la funcion no lleva async
                    // debemos de llamarla de otra forma:
                    let resultadoCalculo = await Task.detached(priority: .userInitiated) {
                        await calculoPesado()
                    }.value
                    
                    resultado = "Calculado : \(resultadoCalculo)"
                    estaCalculando = false
                    
                }
            }
            .buttonStyle(.borderedProminent)
            .disabled(estaCalculando)

        }
        
        
    }
    
    // funcion de calculo pesado
    // que nos retornará un INT
    // nonisolated hace que la función no este atada a la vista
    // el clase se  cambión por que no funcionaba
    //func calculoPesado() -> Int {
    nonisolated func calculoPesado() -> Int {
        var conteo = 0
        // se puede poner con _ por legibilidad
        // el inicio del for con _ es una notación
        // para ya que no nos interesa
        for _ in 0..<20_000_000 {
            conteo += 1
            
        }
        
        return conteo
    }
    
}

#Preview {
    VistaProcesoBloqueante()
}
