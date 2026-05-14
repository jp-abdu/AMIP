import SwiftUI

struct Question4View: View {
    @EnvironmentObject var estado: FormularioState
    @State private var respostaSelecionada = ""
    
    let opcoes = [
        "Do cartório",
        "Não tem",
        "Não sabe"
    ]
    
    var body: some View {
        VStack(spacing: 0) {
            
            // HEADER COM LOGO
            HeaderView()
            
            ScrollView {
                VStack(spacing: 20) {
                    
                    Text("4. REGISTRO CIVIL")
                        .font(.system(size: 23))
                        .bold()
                        .foregroundColor(Color(red: 0.0, green: 0.3, blue: 0.3))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 7.5)
                    
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Tem registro de nascimento:")
                            .font(.headline)
                            .foregroundColor(Color(red: 0.0, green: 0.3, blue: 0.3))
                        
                        // Reutiliza o RadioGroupViews
                        RadioGroupViews(options: opcoes, selected: $estado.q4_respostaSelecionada)
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color(red: 218/255, green: 249/255, blue: 254/255))
                    .cornerRadius(20)
                    
                    // Botões de navegação reutilizáveis
                    FormNavigationButtonsRows(
                        backDestination: Question3View(),
                        nextDestination: Question5View(),
                        canProceed: !estado.q4_respostaSelecionada.isEmpty,
                        onNext: {
                            guard let id = FormularioManager.shared.formularioId else { return }
                            APIService.shared.enviarRegistroCivil(id: id, registro: estado.q4_respostaSelecionada)
                        }
                    )

                }
                .padding()
            }
        }
        .navigationBarHidden(true)
    }
}

struct Question4View_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            Question4View()
                .environmentObject(FormularioState())
        }
    }
}
