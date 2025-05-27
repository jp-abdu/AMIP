import SwiftUI

struct Question11View: View {
    @State private var religiaoSelecionada: String = ""
    
    let opcoesReligiao = [
        "Cristianismo",
        "Islamismo",
        "Hinduísmo",
        "Budismo",
        "Judaísmo",
        "Espiritismo",
        "Outra"
    ]
    
    var body: some View {
        VStack(spacing: 0) {
            HeaderView() // Assumindo que HeaderView já está definida
            
            ScrollView {
                VStack(spacing: 20) {
                    Text("11. RELIGIÃO OU CULTO")
                        .font(.system(size: 23))
                        .bold()
                        .foregroundColor(Color(red: 0.0, green: 0.3, blue: 0.3))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 7.5)
                    
                    // Bloco: Qual sua religião ou culto?
                    blocoRadio(
                        titulo: "QUAL SUA RELIGIÃO OU CULTO?",
                        selecao: $religiaoSelecionada,
                        opcoes: opcoesReligiao
                    )
                    
                    // Botões de navegação
                    FormNavigationButtonsRows(
                        backDestination: Question10View(), // Assumindo que Question10View é a anterior
                        nextDestination: Question12View()  // Assumindo que Question12View é a próxima
                    )
                }
                .padding()
            }
        }
        .navigationBarHidden(true)
    }
    
    // MARK: - Componentes reutilizáveis (copiados aqui para clareza)
    
    @ViewBuilder
    func blocoRadio(titulo: String, selecao: Binding<String>, opcoes: [String]) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(titulo)
                .font(.headline)
                .foregroundColor(Color(red: 0.0, green: 0.3, blue: 0.3))
                .fixedSize(horizontal: false, vertical: true)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            RadioGroupViews(options: opcoes, selected: selecao) // Assumindo RadioGroupViews é um componente existente
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(red: 218/255, green: 249/255, blue: 254/255))
        .cornerRadius(20)
    }
}

struct Question11View_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            Question11View()
        }
    }
}
