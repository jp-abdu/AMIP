import SwiftUI

struct Question7View: View {
    @State private var faleceuPessoa: String = ""
    @State private var dataFalecimento: Date = Date() // Agora é Date
    @State private var nomeCompletoFalecido: String = ""
    @State private var idadeFalecido: String = ""
    @State private var sexoFalecido: String = ""
    
    let opcoesSimNao = ["Sim", "Não"]
    let opcoesSexo = ["Masculino", "Feminino"]

    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter
    }
    
    var body: some View {
        VStack(spacing: 0) {
            HeaderView()
            
            ScrollView {
                VStack(spacing: 20) {
                    Text("7. TAXA DE MORTALIDADE")
                        .font(.system(size: 23))
                        .bold()
                        .foregroundColor(Color(red: 0.0, green: 0.3, blue: 0.3))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 7.5)
                    
                    blocoRadio(titulo: "FALECEU ALGUMA PESSOA QUE MORAVA COM VOCÊ(S)?", selecao: $faleceuPessoa, opcoes: opcoesSimNao)
                    
                    // DatePicker centralizado
                    blocoDatePicker(
                        titulo: "DATA DO FALECIMENTO:",
                        data: $dataFalecimento
                    )
                    
                    blocoDadosFalecido(
                        nome: $nomeCompletoFalecido,
                        idade: $idadeFalecido,
                        sexo: $sexoFalecido
                    )
                    
                    FormNavigationButtonsRows(
                        backDestination: Question6View(),
                        nextDestination: Question8View()
                    )
                }
                .padding()
            }
        }
        .navigationBarHidden(true)
    }
    
    // MARK: - Componentes reutilizáveis
    
    @ViewBuilder
    func blocoRadio(titulo: String, selecao: Binding<String>, opcoes: [String]) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(titulo)
                .font(.headline)
                .foregroundColor(Color(red: 0.0, green: 0.3, blue: 0.3))
                .fixedSize(horizontal: false, vertical: true)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            RadioGroupViews(options: opcoes, selected: selecao)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(red: 218/255, green: 249/255, blue: 254/255))
        .cornerRadius(20)
    }

    // NOVO: bloco para o DatePicker centralizado
    @ViewBuilder
    func blocoDatePicker(titulo: String, data: Binding<Date>) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(titulo)
                .font(.headline)
                .foregroundColor(Color(red: 0.0, green: 0.3, blue: 0.3))
                .fixedSize(horizontal: false, vertical: true)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            // O segredo está aqui!
            HStack {
                Spacer()
                DatePicker(
                    "",
                    selection: data,
                    displayedComponents: .date
                )
                // Troque o estilo aqui conforme desejar:
                // .datePickerStyle(.compact) // Centraliza só em alguns devices/iOS
                .datePickerStyle(.wheel)     // Centraliza em todos!
                .environment(\.locale, Locale(identifier: "pt_BR"))
                Spacer()
            }
            .frame(maxWidth: .infinity)
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
