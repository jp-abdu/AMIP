//
//  Question2View.swift
//  TesteAmip
//
//  Created by ANDRE LUIZ MENDES DO NASCIMENTO RIBEIRO on 20/05/25.
//

import SwiftUI

struct Question12View: View {
    // aqui você deve declarar os @State necessários para as respostas desta tela
    @State private var respostaExemplo = ""
    @State private var opcao12 = ""
    
    let opcoes12 = [
        "Sim",
        "Não"
    ]
    
    var body: some View {
        VStack(spacing: 20) {
            Text("12. AUTISMO (PARA TODAS AS PESSOAS)")
                .font(. system(size: 25))
                .foregroundColor(Color(red: 0.0, green: 0.3, blue: 0.3))
                
            
            VStack(alignment: .leading, spacing: 20) {
                Text("Algum morador já foi diagnosticado(a) com autismo por algum profissional de saúde?")
                    .foregroundColor(Color(red: 0.0, green: 0.3, blue: 0.3))
                    .font(. system(size: 30))

                ForEach(opcoes12, id: \.self) { opcao in
                    HStack(spacing: 16) {
                        ZStack {
                            Circle()
                                .stroke(Color.black, lineWidth: 1)
                                .frame(width: 35, height: 35)
                                .font(. system(size: 160))
                            if opcao12 == opcao {
                                Circle()
                                    .fill(Color.blue)
                                    .frame(width: 25, height: 25)
                            }
                        }

                        Text(opcao)
                            .foregroundColor(.black)
                            .fixedSize(horizontal: false, vertical: true)
                            .font(. system(size: 40))
                    }
                    .contentShape(Rectangle()) // Torna toda a linha clicável
                    .onTapGesture {
                        opcao12 = opcao
                    }
                }
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color(red: 218/255, green: 249/255, blue: 254/255))
            .cornerRadius(20)
            //.frame(width: 320, height: 220, alignment: .leading)
            
            Spacer()
            VStack(alignment: .leading, spacing: 5){
            HStack(spacing: 10){
                NavigationLink(destination: Question11View()) {
                    Text("Voltar")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .foregroundColor(Color(red: 0/255, green: 104/255, blue: 150/255))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color(red: 0/255, green: 104/255, blue: 150/255), lineWidth: 1.8)
                        )
                        .cornerRadius(10)
                        
                }
            // BOTÃO DE NAVEGAÇÃO PARA A PRÓXIMA TELA
            NavigationLink(destination: FormularioEnviadoView()) {
                Text("Finalizar")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color(red: 0/255, green: 104/255, blue: 150/255))
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            }
                NavigationLink(destination: HomeView()) {
                    Text("Retornar ao Home")
                        .foregroundColor(Color(red: 0/255, green: 104/255, blue: 150/255))
                        .underline(true, color: Color(red: 0/255, green: 104/255, blue: 150/255))
                }
            }
            .padding(.horizontal)
        }
        .padding()
    }
}


struct Question12View_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            Question12View()
        }
    }
}
