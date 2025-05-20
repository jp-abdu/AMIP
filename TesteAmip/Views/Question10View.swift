///
//  Question2View.swift
//  TesteAmip
//
//  Created by ANDRE LUIZ MENDES DO NASCIMENTO RIBEIRO on 20/05/25.
//

import SwiftUI

struct Question10View: View {
    // aqui você deve declarar os @State necessários para as respostas desta tela
    @State private var respostaExemplo = ""
    
    var body: some View {
        VStack(spacing: 20) {
            Text("PERGUNTA 10")
                .font(.headline)
                .foregroundColor(Color(red: 0.0, green: 0.3, blue: 0.3))
            
            // Exemplo de campo de resposta
            TextField("Digite sua resposta", text: $respostaExemplo)
                .padding(8)
                .background(Color.white)
                .cornerRadius(8)
            
            Spacer()
            
            // BOTÃO DE NAVEGAÇÃO PARA A PRÓXIMA TELA
            NavigationLink(destination: Question11View()) {
                Text("Próxima")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.horizontal)
        }
        .padding()
        .navigationTitle("Pergunta 10")
    }
}

struct Question10View_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            Question10View()
        }
    }
}
