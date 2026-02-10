//
//  04_VistaSecuenciaEnParalelo.swift
//  Curso-iOS-Asincronia
//
//  Created by Equipo 9 on 10/2/26.
//

import SwiftUI

struct VistaSecuenciaEnParalelo: View {
    
    @State private var log = ""
    @State private var tirempoReal = 0.0
    
    var body: some View {
        // vamos a mostrar un log
        VStack(spacing: 10) {
            Text(log)
                .frame(maxWidth: .infinity, alignment: .leading)
                .frame(height: 300)
                .background(.gray.opacity(0.2))
            
            HStack {
                Button("Desayuno secunecial"){
                    Task{
                        await prepararDesayunoSecuencial()
                    }
                    
                }
                .buttonStyle(.bordered)
                
                Button("Desayuno en paralelop"){
                    Task {
                        await preparandoDesayunoEnParalelo()
                    }
                }
                .buttonStyle(.borderedProminent)
            }
            
        }
    }
    
    // Función secuencial una y luego la siguiente
    func prepararDesayunoSecuencial() async {
        // llamamos a una y luego a la siguiente
        log = "⏱️ Iniciando modo secuencial \n ------------------ \n"
        let inicio = Date()
        
        let café = await hacerCafe()
        log += "☕️ \(café) \n"
        
        let pan = await tostarPan()
        log += "🥖 \(pan) \n"

        let fin = Date()
        let total = fin.timeIntervalSince(inicio).formatted()
        log += "🕒 Tiempo total: \(total) \n"
        
    }
    
    
    // Función en papalelo se ejecutan a la misma vez
    func preparandoDesayunoEnParalelo() async {
        log = "🚀 Ejecución en paralelo \n ------------------ \n"
        let inicio = Date()
        
        
        async let  tareaCafe = hacerCafe()
        async let tareaTostada = tostarPan()
        
        // creamos una tupla
        let (resultadoCafe, resultadoTostada) = await (tareaCafe, tareaTostada)
        
        log += resultadoCafe
        log += resultadoTostada
        
        
        let fin = Date()
        let total = fin.timeIntervalSince(inicio).formatted()
        log += "🕒 Tiempo total: \(total) \n"
    }
    
    // funciones de los procesos
    func hacerCafe() async -> String {
        log += "Preparando el café ☕️  \n"
        
        try? await Task.sleep(for: .seconds(2))
        
        return "Café listo ✅ \n"
    }
    
    func tostarPan() async -> String {
        
        log += "Tostando el pan  🍞\n"
        
        try? await Task.sleep(for: .seconds(3))
        return "Tostada listo ✅ \n"
    }
    
}

#Preview {
    VistaSecuenciaEnParalelo()
}
