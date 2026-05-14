import SwiftUI

struct Question7View: View {
    @EnvironmentObject var estado: FormularioState
    /*
    @State private var faleceuPessoa: String = ""
    @State private var dataFalecimento: Date = Date()
    @State private var nomeCompletoFalecido: String = ""
    @State private var idadeFalecido: String = ""
    @State private var sexoFalecido: String = ""
    */
     
    let opcoesSimNao = ["Sim", "Não"]
    let opcoesSexo = ["Masculino", "Feminino"]

    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter
    }

    // Se "Não", só exige a resposta principal
    var canProceed: Bool {
        if estado.q7_faleceuPessoa == "Não" {
            return true
        }
        return estado.q7_faleceuPessoa == "Sim" &&
               !estado.q7_nomeCompletoFalecido.isEmpty &&
               !estado.q7_idadeFalecido.isEmpty &&
               !estado.q7_sexoFalecido.isEmpty
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
                        selecao: $estado.q7_faleceuPessoa,
                        opcoes: opcoesSimNao
                    )
                    
                    // Campos extras só aparecem se houve falecimento
                    if estado.q7_faleceuPessoa == "Sim" {
                        blocoDatePicker(
                            titulo: "DATA DO FALECIMENTO:",
                            data: $estado.q7_dataFalecimento
                        )
                        
                        blocoDadosFalecido(
                            nome: $estado.q7_nomeCompletoFalecido,
                            idade: $estado.q7_idadeFalecido,
                            sexo: $estado.q7_sexoFalecido
                        )
                    }
                    
                    FormNavigationButtonsRows(
                        backDestination: Question6View(),
                        nextDestination: Question8View(),
                        canProceed: canProceed,
                        onNext: {}
                    )
                }
                .padding()
            }
        }
        .navigationBarHidden(true)
        // Limpa os campos de falecido ao trocar para "Não"
        .onChange(of: estado.q7_faleceuPessoa) { novoValor in
            if novoValor == "Não" {
                estado.q7_nomeCompletoFalecido = ""
                estado.q7_idadeFalecido = ""
                estado.q7_sexoFalecido = ""
                estado.q7_dataFalecimento = Date()
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
                .environmentObject(FormularioState())
        }
    }
}
