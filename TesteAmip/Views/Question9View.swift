import SwiftUI

struct Question9View: View {
    @State private var pessoasSabemLerEscrever: String = "Selecione" // Para o Picker
    @State private var frequentaEscolaCreche: String = ""
    @State private var cursoQueFrequenta: String = ""
    @State private var concluiuOutroSuperior: String = ""
    
    let opcoesNumericas = ["Selecione", "1", "2", "3", "4", "5", "6", "7+"] // Usado no Picker
    let opcoesSimNao = ["Sim", "Não"]
    
    let opcoesFrequentaEscola = [
        "Sim",
        "Não, mas já frequentou",
        "Não, nunca frequentou"
    ]
    
    let opcoesCursoFrequenta = [
        "Pré-escola",
        "Creche",
        "Alfabetização de jovens e adultos",
        "Regular do ensino fundamental",
        "Educação de jovens e adultos (eja) do ensino fundamental",
        "Regular do ensino médio",
        "Superior de graduação",
        "Educação de jovens e adultos (eja) do ensino médio",
        "Especialização de nível superior (duração mínima de 360 horas)",
        "Mestrado",
        "Doutorado",
        "Nenhum"
    ]
    
    var body: some View {
        VStack(spacing: 0) {
            HeaderView() // Assumindo que HeaderView já está definida
            
            ScrollView {
                VStack(spacing: 20) {
                    Text("9. EDUCAÇÃO (IDADE: 5 ANOS+)")
                        .font(.system(size: 23))
                        .bold()
                        .foregroundColor(Color(red: 0.0, green: 0.3, blue: 0.3))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 7.5)
                    
                    // Bloco: Quantas pessoas sabem ler e escrever? (Usando blocoPergunta adaptado para Picker)
                    blocoPergunta(
                        titulo: "QUANTAS PESSOAS SABEM LER E ESCREVER?",
                        selecao: $pessoasSabemLerEscrever,
                        opcoesPicker: opcoesNumericas // Passando as opções para o Picker
                    )
                    
                    // Bloco: FREQUENTA ESCOLA OU CRECHE?
                    blocoRadio(
                        titulo: "FREQUENTA ESCOLA OU CRECHE? (Escola inclui desde cursos da pré-escola até o doutorado)",
                        selecao: $frequentaEscolaCreche,
                        opcoes: opcoesFrequentaEscola
                    )
                    
                    // Bloco: QUAL É O CURSO QUE FREQUENTA?
                    blocoRadio(
                        titulo: "QUAL É O CURSO QUE FREQUENTA?",
                        selecao: $cursoQueFrequenta,
                        opcoes: opcoesCursoFrequenta
                    )
                    
                    // Bloco: JÁ CONCLUIU ALGUM OUTRO CURSO SUPERIOR DE GRADUAÇÃO?
                    blocoRadio(
                        titulo: "JÁ CONCLUIU ALGUM OUTRO CURSO SUPERIOR DE GRADUAÇÃO?",
                        selecao: $concluiuOutroSuperior,
                        opcoes: opcoesSimNao
                    )
                    
                    // Botões de navegação
                    FormNavigationButtonsRows(
                        backDestination: Question8View(), // Assumindo que Question8View é a anterior
                        nextDestination: Question10View() // Assumindo que Question10View é a próxima
                    )
                }
                .padding()
            }
        }
        .navigationBarHidden(true)
    }
    
    // MARK: - Componentes reutilizáveis (adaptados ou copiados aqui para clareza)
    
    @ViewBuilder
    func blocoPergunta(titulo: String, selecao: Binding<String>, opcoesPicker: [String]) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(titulo)
                .font(.headline)
                .foregroundColor(Color(red: 0.0, green: 0.3, blue: 0.3))
                .fixedSize(horizontal: false, vertical: true)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Picker("Selecione o número:", selection: selecao) {
                ForEach(opcoesPicker, id: \.self) { opcao in
                    Text(opcao)
                }
            }
            .pickerStyle(MenuPickerStyle())
            .padding(8)
            .background(Color.white)
            .cornerRadius(8)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(red: 218/255, green: 249/255, blue: 254/255))
        .cornerRadius(20)
    }
    
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

struct Question9View_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            Question9View()
        }
    }
}
