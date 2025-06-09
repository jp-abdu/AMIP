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
                    
                    blocoRadio(titulo: "FALECEU ALGUMA PESSOA QUE MORAVA COM VOCÊ(S) NOS ULTIMOS DOIS ANOS(OU DESDE O ULTIMO SENSO)?", selecao: $faleceuPessoa, opcoes: opcoesSimNao)
                    
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
                        nextDestination: Question8View(),
                        canProceed: !faleceuPessoa.isEmpty &&
                                    !nomeCompletoFalecido.isEmpty &&
                                    !idadeFalecido.isEmpty &&
                                    !sexoFalecido.isEmpty,
                        onNext: {
                            postResposta(pergunta: "Houve falecimento", resposta: faleceuPessoa, descricao: "Se alguém faleceu no domicílio")
                            postResposta(pergunta: "Data do falecimento", resposta: dateFormatter.string(from: dataFalecimento), descricao: "Data em que ocorreu o falecimento")
                            postResposta(pergunta: "Nome do falecido", resposta: nomeCompletoFalecido, descricao: "Nome completo da pessoa falecida")
                            postResposta(pergunta: "Idade do falecido", resposta: idadeFalecido, descricao: "Idade da pessoa falecida")
                            postResposta(pergunta: "Sexo do falecido", resposta: sexoFalecido, descricao: "Sexo da pessoa falecida")
                        }
                    )

                }
                .padding()
            }
        }
        .navigationBarHidden(true)
    }
    
    func postResposta(pergunta: String, resposta: String, descricao: String) {
        guard let url = URL(string: "https://mysite-sdz6.onrender.com/indicadores") else { return }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let json: [String: String] = [
            "pergunta": pergunta,
            "resposta": resposta,
            "descricao": descricao
        ]

        do {
            let jsonData = try JSONSerialization.data(withJSONObject: json, options: [])
            request.httpBody = jsonData

            URLSession.shared.dataTask(with: request) { _, response, error in
                if let error = error {
                    print("Erro ao enviar: \(error)")
                } else if let response = response as? HTTPURLResponse {
                    print("Status: \(response.statusCode)")
                }
            }.resume()
        } catch {
            print("Erro ao converter JSON: \(error)")
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
