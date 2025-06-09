import SwiftUI

struct Question1View: View {
    @State private var ruaSelecionada = ""
    @State private var numero = ""
    @State private var complemento = ""
    @State private var especieSelecionada = ""
    @State private var tipoSelecionado = ""

    let ruas = [
        "Selecione a Rua", "R. Marina do Sol", "R. Marina do Frade",
        "R. Marina dos Coqueiros", "R. Marina da Lua", "R. Marina do Bosque",
        "R. Marina Porto Bali", "R. Marina das Flores", "R. Marina das Estrelas",
        "R. Marina Ponta Leste"
    ]

    let especieDomicilio = [
        "Domicílio particular permanente ocupado",
        "Domicílio particular improvisado ocupado",
        "Domicílio coletivo com morador"
    ]

    let tipoDomicilio = [
        "Casa", "Casa de vila ou condomínio",
        "Habitação em casa de comodos ou cortiço",
        "Estrutura residencial permanente degradada ou inacabada",
        "Asilo ou outra instituição de permanência para idosos",
        "Hotel ou pensão", "Alojamento", "Outros"
    ]

    var body: some View {
        VStack(spacing: 0) {
            HeaderView()

            ScrollView {
                VStack(spacing: 20) {
                    Text("1. IDENTIFICAÇÃO DE DOMICÍLIO")
                        .font(.system(size: 23))
                        .bold()
                        .foregroundColor(Color(red: 0.0, green: 0.3, blue: 0.3))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 7.5)

                    // Bloco: Endereço
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Endereço:")
                            .font(.headline)
                            .foregroundColor(Color(red: 0.0, green: 0.3, blue: 0.3))

                        Picker("Selecione a rua", selection: $ruaSelecionada) {
                            ForEach(ruas, id: \.self) { rua in
                                Text(rua)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                        .padding(8)
                        .background(Color.white)
                        .cornerRadius(8)

                        LabeledTextFieldViews(title: "Número", text: $numero, keyboardType: .numberPad)
                        LabeledTextFieldViews(title: "Complemento", text: $complemento)
                    }
                    .padding()
                    .background(Color(red: 218/255, green: 249/255, blue: 254/255))
                    .cornerRadius(20)

                    // Bloco: Espécie de domicílio
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Espécie de domicílio:")
                            .font(.headline)
                            .foregroundColor(Color(red: 0.0, green: 0.3, blue: 0.3))

                        RadioGroupViews(options: especieDomicilio, selected: $especieSelecionada)
                    }
                    .padding()
                    .background(Color(red: 218/255, green: 249/255, blue: 254/255))
                    .cornerRadius(20)

                    // Bloco: Tipo de domicílio
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Tipo de domicílio:")
                            .font(.headline)
                            .foregroundColor(Color(red: 0.0, green: 0.3, blue: 0.3))

                        RadioGroupViews(options: tipoDomicilio, selected: $tipoSelecionado)
                    }
                    .padding()
                    .background(Color(red: 218/255, green: 249/255, blue: 254/255))
                    .cornerRadius(20)

                    // Botões de navegação
                    FormNavigationButtonsRows(
                        backDestination: HomeView(),
                        nextDestination: Question2View(),
                        canProceed: ruaSelecionada != "" &&
                                    ruaSelecionada != "Selecione a Rua" &&
                                    !numero.isEmpty &&
                                    !especieSelecionada.isEmpty &&
                                    !tipoSelecionado.isEmpty,
                        onNext: {
                            let respostas: [(String, String, String)] = [
                                ("Rua", ruaSelecionada, "Endereço do domicílio"),
                                ("Número", numero, "Número do endereço"),
                                ("Complemento", complemento, "Complemento do endereço"),
                                ("Espécie de domicílio", especieSelecionada, "Tipo de ocupação"),
                                ("Tipo de domicílio", tipoSelecionado, "Tipo de construção")
                            ]

                            for item in respostas {
                                postResposta(pergunta: item.0, resposta: item.1, descricao: item.2)
                            }
                        }
                    )
                }
                .padding()
            }
        }
        .navigationBarHidden(true)
        
    }
    
    func postResposta(pergunta: String, resposta: String, descricao: String) {
        guard let url = URL(string: "https://mysite-sdz6.onrender.com/api/indicadores/") else { return }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
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

}

struct Question1View_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            Question1View()
        }
    }
}
