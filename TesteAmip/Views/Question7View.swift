import SwiftUI

struct Question7View: View {
    @State private var faleceuPessoa: String = ""
    @State private var dataFalecimento: String = ""
    @State private var nomeCompletoFalecido: String = ""
    @State private var idadeFalecido: String = ""
    @State private var sexoFalecido: String = ""
    
    let opcoesSimNao = ["Sim", "Não"]
    let opcoesSexo = ["Masculino", "Feminino"]
    
    var body: some View {
        VStack(spacing: 0) {
            HeaderView() // Assumindo que HeaderView já está definida
            
            ScrollView {
                VStack(spacing: 20) {
                    Text("7. TAXA DE MORTALIDADE")
                        .font(.system(size: 23))
                        .bold()
                        .foregroundColor(Color(red: 0.0, green: 0.3, blue: 0.3))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 7.5)
                    
                    // Bloco: Faleceu alguma pessoa que morava com você(s)?
                    blocoRadio(titulo: "FALECEU ALGUMA PESSOA QUE MORAVA COM VOCÊ(S)?", selecao: $faleceuPessoa, opcoes: opcoesSimNao)
                    
                    // Bloco: Data do Falecimento
                    blocoCampoTexto(titulo: "DATA DO FALECIMENTO:", texto: $dataFalecimento, placeholder: "DD/MM/AAAA", keyboardType: .numbersAndPunctuation)
                    
                    // Bloco: Nome completo, Idade e Sexo
                    blocoDadosFalecido(
                        nome: $nomeCompletoFalecido,
                        idade: $idadeFalecido,
                        sexo: $sexoFalecido
                    )
                    
                    // Botões de navegação
                    FormNavigationButtonsRows(
                        backDestination: Question6View(), // Assumindo que Question6View é a anterior
                        nextDestination: Question8View()  // Assumindo que Question8View é a próxima
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
    
    @ViewBuilder
    func blocoCampoTexto(titulo: String, texto: Binding<String>, placeholder: String = "", keyboardType: UIKeyboardType = .default) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(titulo)
                .font(.headline)
                .foregroundColor(Color(red: 0.0, green: 0.3, blue: 0.3))
                .fixedSize(horizontal: false, vertical: true)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            LabeledTextFieldViews(title: placeholder, text: texto, keyboardType: keyboardType) // Assumindo LabeledTextFieldViews é um componente existente
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(red: 218/255, green: 249/255, blue: 254/255))
        .cornerRadius(20)
    }

    @ViewBuilder
    func blocoDadosFalecido(nome: Binding<String>, idade: Binding<String>, sexo: Binding<String>) -> some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("NOME COMPLETO, IDADE E SEXO:")
                .font(.headline)
                .foregroundColor(Color(red: 0.0, green: 0.3, blue: 0.3))
                .fixedSize(horizontal: false, vertical: true)
                .frame(maxWidth: .infinity, alignment: .leading)

            LabeledTextFieldViews(title: "Nome Completo", text: nome)
            LabeledTextFieldViews(title: "Idade", text: idade, keyboardType: .numberPad)
            
            RadioGroupViews(options: opcoesSexo, selected: sexo)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(red: 218/255, green: 249/255, blue: 254/255))
        .cornerRadius(20)
    }
}

struct Question7View_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            Question7View()
        }
    }
}
