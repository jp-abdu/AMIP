import SwiftUI

struct FormularioEnviadoView: View {
    @Environment(\.presentationMode) var presentationMode
    
    // 1. Injetamos o estado para podermos limpar os dados
    @EnvironmentObject var estado: FormularioState

    var body: some View {
        VStack(spacing: 30) {
            Spacer()
            
            Image("certo")
                .resizable()
                .scaledToFit()
                .frame(height: 125) // Diminui um pouco para garantir que cabe
                .padding(.horizontal, 16)
            
            Text("Formulário enviado com sucesso!")
                .font(.title2)
                .bold()
                .multilineTextAlignment(.center)
            
            // Substitua o NavigationLink por este Button
                        Button(action: {
                            FormularioManager.shared.formularioId = nil
                            // Volta para a raiz!
                            estado.isFormularioAtivo = false
                        }) {
                            Text("Voltar à Home")
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                                .padding(.horizontal)
                        }
                        .simultaneousGesture(TapGesture().onEnded {
                            // Apenas resetamos o ID. A limpeza das variáveis ocorrerá ao clicar em "Iniciar" na Home
                            FormularioManager.shared.formularioId = nil
                        })            // 2. A mágica acontece aqui: ao tocar no link, limpamos a memória e o ID
            .simultaneousGesture(TapGesture().onEnded {
                estado.limparFormulario()
                FormularioManager.shared.formularioId = nil
            })

            Spacer()
        }
        .padding()
        .background(Color(red: 0.85, green: 1.0, blue: 1.0).ignoresSafeArea())
        .navigationBarBackButtonHidden(true)
    }
}

struct FormularioEnviadoView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            FormularioEnviadoView()
                .environmentObject(FormularioState()) // Adicionado para não quebrar o Preview
        }
    }
}
