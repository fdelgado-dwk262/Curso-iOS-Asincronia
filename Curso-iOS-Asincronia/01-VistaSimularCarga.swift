//
//  ContentView.swift
//  Curso-iOS-Asincronia
//
//  Created by Equipo 9 on 10/2/26.
//

import SwiftUI

struct VistaSimularCarga: View {

    @State private var mensaje = "Presiona el boton"
    @State private var cargando: Bool = false
    
    var body: some View {
        VStack {
            if cargando {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
            } else {
                Text(mensaje)
                    .font(.title2)
                // Muestra spinner
                Button("Simular descarga de datos") {
                    // para el usoa de asincronia
                    Task {
                        await procesarDescarga()
                    }

                }
                .padding(10)
                .background(.blue)
                .foregroundStyle(.white)
                .disabled(cargando)
                
                // no se debe de hacer ... bloquea la app
                // pone a "dormi el hilo proincipal"
                Button("Simular descarga bloqueanbte") {
                    cargando = true
                    mensaje = "Conectando al servidor ..."
                    Thread.sleep(forTimeInterval: 3)
                    mensaje = "¡ Datos cargados! "
                    cargando = false
                }
                .padding(10)
                .background(.green)
                .foregroundStyle(.white)
                .disabled(cargando)
                
            }
        }
    }
    
    func procesarDescarga() async {
        cargando = true
        mensaje = "Conectando al servidor ..."
        
        // simulamos la carga
        try? await Task.sleep(for: .seconds(3))
        
        mensaje = "¡ Datos cargados! "
        cargando = false
    }
}

#Preview {
    VistaSimularCarga()
}
