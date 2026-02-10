//
//  05-VistaMainActor.swift
//  Curso-iOS-Asincronia
//
//  Created by Equipo 9 on 10/2/26.
//

import SwiftUI
import Observation


// para que se ejecute en el hilo principal @MainActor
// o bien en la clase o solo encima de la función
// para evitar problemas de concurrencia
// nota si tenemos una clase con varias funciones yh solo lo utiliza una

// sinó debe de estar en la clase por encima del observable


// Enresumen ,.-
/*
 @MainActor asegura que las actualizaciones de la interfaz ocurran en el huilo principal de la app
 Se puede anotar:
- La clase entera
- En una función
- Se puede usar la palabra clave "nonisolated" para exluir métodos específicos de la ejecuciónd el hilo proncipal
 
 
 */
@MainActor
@Observable
class UsuarioViewModel {
 
    var nombrebeUsuario = "Cargando ..."
    
    
    func actualizarNombreusuario() async {
        // simulamdo descarga de datos de internet
        try? await Task.sleep(for: .seconds(2))
        
        nombrebeUsuario = "El dato traido "
        
    }
    
}


struct VistaMainActor: View {
    
    // instanciamos el observable
    @State private var viewModel = UsuarioViewModel()
    
    
    var body: some View {
        Text(viewModel.nombrebeUsuario)
            .task {
                await viewModel.actualizarNombreusuario()
            }
    }
    
}

#Preview {
    VistaMainActor()
}
