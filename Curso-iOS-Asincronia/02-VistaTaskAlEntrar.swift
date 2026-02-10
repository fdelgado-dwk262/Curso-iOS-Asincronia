//
//  VistaTaskAlEntrar.swift
//  Curso-iOS-Asincronia
//
//  Created by Equipo 9 on 10/2/26.
//

import SwiftUI

struct VistaTaskAlEntrar: View {
    @State private var nombre = "Cargando ...."
    @State private var biografia = ""
    
    var body: some View {
    
        VStack(spacing: 20) {
            Image(systemName: "person.circle.fill")
                .font(.system(size: 80))
                .foregroundColor(Color.blue)
            Text(nombre)
                .font(.title)
                .bold()
            Text(biografia)
                .font(.caption)
                .foregroundColor(.secondary)
        }
        // se ejecuta el task cuando la vista va a aparecer
        // task se cancela si salimos de la vista
        // ejemplo si lanzamos un seeht  y salimos cancela la carga
        // No usamos el onAppear para temas asincronas
        .task {
           
            await cargandoPerfil()
        }
        
    }
    func cargandoPerfil() async {
        try? await Task.sleep(for: .seconds(4))
        
        nombre = "Erick"
        biografia = "Desarrollador SwiftUI"
    }
}

#Preview {
    VistaTaskAlEntrar()
}
