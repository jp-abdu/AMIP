import SwiftUI

struct Question8View: View {
    @State private var dificuldadeEnxergar: String = ""
    @State private var dificuldadeOuvir: String = ""
    @State private var dificuldadeAndar: String = ""
    
    let opcoesDificuldade = [
        "Tem, não consegue de modo algum",
        "Tem muita dificuldade",
        "Tem alguma dificuldade",
        "Não tem dificuldade"
    ]
    
    var body: some View {
        VStack(spacing: 0) {
            HeaderView() // Assumindo que HeaderView já está definida
            
            ScrollView {
                VStack(spacing: 20) {
                    Text("8. PESSOAS COM DEFICIÊNCIA (IDADE: 2 ANOS+)")
                        .font(.system(size: 23))
                        .bold()
                        .foregroundColor(Color(red: 0.0, green: 0.3, blue: 0.3))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 7.5)
                    
                    // Bloco: Dificuldade de enxergar
                    blocoRadio(
                        titulo: "TEM DIFICULDADE PERMANENTE DE ENXERGAR MESMO USANDO ÓCULOS OU LENTES DE CONTATO?",
                        selecao: $dificuldadeEnxergar,
                        opcoes: opcoesDificuldade
                    )
                    
                    // Bloco: Dificuldade de ouvir
                    blocoRadio(
                        titulo: "TEM DIFICULDADE PERMANENTE PARA OUVIR, MESMO USANDO APARELHOS AUDITIVOS?",
                        selecao: $dificuldadeOuvir,
                        opcoes: opcoesDificuldade
                    )
                    
                    // Bloco: Dificuldade de andar ou subir degraus
                    blocoRadio(
                        titulo: "TEM DIFICULDADE PERMANENTE PARA ANDAR OU SUBIR DEGRAUS, MESMO USANDO PRÓTESE, BENGALA OU APARELHO DE AUXÍLIO?",
                        selecao: $dificuldadeAndar,
                        opcoes: opcoesDificuldade
                    )
                    
                    // Botões de navegação
                    FormNavigationButtonsRows(
                        backDestination: Question7View(), // Assumindo que Question7View é a anterior
                        nextDestination: Question9View()  // Assumindo que Question9View é a próxima
                    )
                }
                .padding()
            }
        }
        .navigationBarHidden(true)
    }
    
    // MARK: - Componentes reutilizáveis (iguais aos das views anteriores, adaptados ou copiados aqui para clareza)
    
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

struct Question8View_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            Question8View()
        }
    }
}
