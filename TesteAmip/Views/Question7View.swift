import SwiftUI

struct Question7View: View {
    @State private var faleceuPessoa: String = ""
    @State private var dataFalecimento: Date = Date()
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

    // Se "Não", só exige a resposta principal
    var canProceed: Bool {
        if faleceuPessoa == "Não" {
            return true
        }
        return faleceuPessoa == "Sim" &&
               !nomeCompletoFalecido.isEmpty &&
               !idadeFalecido.isEmpty &&
               !sexoFalecido.isEmpty
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
                    
                    blocoRadio(
                        titulo: "FALECEU ALGUMA PESSOA QUE MORAVA COM VOCÊ(S) NOS ULTIMOS DOIS ANOS(OU DESDE O ULTIMO SENSO)?",
                        selecao: $faleceuPessoa,
                        opcoes: opcoesSimNao
                    )
                    
                    // Campos extras só aparecem se houve falecimento
                    if faleceuPessoa == "Sim" {
                        blocoDatePicker(
                            titulo: "DATA DO FALECIMENTO:",
                            data: $dataFalecimento
                        )
                        
                        blocoDadosFalecido(
                            nome: $nomeCompletoFalecido,
                            idade: $idadeFalecido,
                            sexo: $sexoFalecido
                        )
                    }
                    
                    FormNavigationButtonsRows(
                        backDestination: Question6View(),
                        nextDestination: Question8View(),
                        canProceed: canProceed,
                        onNext: {
                            guard let id = FormularioManager.shared.formularioId else { return }
                            APIService.shared.enviarMortalidade(
                                id: id,
                                houveFalecimento: faleceuPessoa,
                                dataFalecimento: faleceuPessoa == "Sim" ? dateFormatter.string(from: dataFalecimento) : nil,
                                nomeFalecido: nomeCompletoFalecido.isEmpty ? nil : nomeCompletoFalecido,
                                idadeFalecido: idadeFalecido.isEmpty ? nil : idadeFalecido,
                                sexoFalecido: sexoFalecido.isEmpty ? nil : sexoFalecido
                            )
                        }
                    )
                }
                .padding()
            }
        }
        .navigationBarHidden(true)
        // Limpa os campos de falecido ao trocar para "Não"
        .onChange(of: faleceuPessoa) { novoValor in
            if novoValor == "Não" {
                nomeCompletoFalecido = ""
                idadeFalecido = ""
                sexoFalecido = ""
                dataFalecimento = Date()
            }
        }
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

    @ViewBuilder
    func blocoDatePicker(titulo: String, data: Binding<Date>) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(titulo)
                .font(.headline)
                .foregroundColor(Color(red: 0.0, green: 0.3, blue: 0.3))
                .fixedSize(horizontal: false, vertical: true)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack {
                Spacer()
                DatePicker(
                    "",
                    selection: data,
                    displayedComponents: .date
                )
                .datePickerStyle(.wheel)
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
