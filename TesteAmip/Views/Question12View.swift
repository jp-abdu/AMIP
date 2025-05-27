import SwiftUI

struct Question12View: View {
    @State private var diagnosticadoComAutismo: String = ""
    
    let opcoesSimNao = ["Sim", "Não"]
    
    var body: some View {
        VStack(spacing: 0) {
            HeaderView() // Assumindo que HeaderView já está definida
            
            ScrollView {
                VStack(spacing: 20) {
                    Text("12. AUTISMO (PARA TODAS AS PESSOAS)")
                        .font(.system(size: 23))
                        .bold()
                        .foregroundColor(Color(red: 0.0, green: 0.3, blue: 0.3))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 7.5)
                    
                    // Bloco: Algum morador já foi diagnosticado(a) com autismo por algum profissional de saúde?
                    blocoRadio(
                        titulo: "ALGUM MORADOR JÁ FOI DIAGNOSTICADO(A) COM AUTISMO POR ALGUM PROFISSIONAL DE SAÚDE?",
                        selecao: $diagnosticadoComAutismo,
                        opcoes: opcoesSimNao
                    )
                    
                    // Botões de navegação
                    FormNavigationButtonsRows(
                        backDestination: Question11View(), // Assumindo que Question11View é a anterior
                        nextDestination: FormularioEnviadoView()  // Assumindo que Question13View é a próxima
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

struct Question12View_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            Question12View()
        }
    }
}
