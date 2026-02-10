//
//  06-VistaContador.swift
//  Curso-iOS-Asincronia
//
//  Created by Equipo 9 on 10/2/26.
//

import SwiftUI
import Observation

// Idea de contador

@MainActor
@Observable
class ContadorViewModel{
    var valor = 0
    var estaContando: Bool = false
    
    // funcion de contador
    func iniciarContador() async {
        valor = 0 // reiniciamos el valor
        estaContando = true
        
        for cuenta in 1...10 {
             
            // se duerme cada x segundos con el task seelp
            try? await Task.sleep(for: .seconds(1))
            valor = cuenta
        }
        
        estaContando = false
    }
}


struct VistaContador: View {
    
    @State private var viewModel = ContadorViewModel()
    
    var body: some View {
        
        
        VStack(spacing: 20) {
            
            Text("Comtador Async")
                .font(.largeTitle)
            
            Text("\(viewModel.valor)")
                .font(.system(size: 100))
                .padding()
                .foregroundStyle(viewModel.estaContando ? .green : .gray)
                
            
            if viewModel.estaContando {
                ProgressView("contando hasta 10")
                    .controlSize( .large)
            } else {
                Button("Inicia contador") {
                    Task {
                        await viewModel.iniciarContador()
                        
                    }
                }
                .disabled(viewModel.estaContando)
                .buttonStyle(.bordered)
            }
        }
        
        // según se inicia la vista y solo se ejecuta una vez
        .task {
            await viewModel.iniciarContador()
        }
        
    }
}

#Preview {
    VistaContador()
}
