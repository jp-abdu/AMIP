import SwiftUI

struct Question4View: View {
    @State private var respostaSelecionada = ""
    
    let opcoes = [
        "Do cartório",
        "Nao tem",
        "Nao sabe"
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
                        RadioGroupViews(options: opcoes, selected: $respostaSelecionada)
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color(red: 218/255, green: 249/255, blue: 254/255))
                    .cornerRadius(20)
                    
                    // Botões de navegação reutilizáveis
                    FormNavigationButtonsRows(
                        backLabel: "Voltar",
                        nextLabel: "Próxima",
                        backDestination: Question3View(),
                        nextDestination: Question5View()
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
        }
    }
}
