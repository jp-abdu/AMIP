import SwiftUI

struct Question2View: View {
    @State private var numeroMoradores = ""
    @State private var nomeCompleto = ""
    @State private var dataNascimento = Date()
    @State private var dataNascimentoSelecionada = false
    @State private var mostrandoSelecaoData = false
    @State private var sexoSelecionado = ""
    @State private var parentescoSelecionado = ""
    @State private var situacaoDomicilioSelecionada = ""
    
    let opcoesSexo = ["Masculino", "Feminino"]
    
    let opcoesParentesco = [
        "Cônjuge ou companheiro(a) de sexo diferente",
        "Cônjuge ou companheiro(a) do mesmo sexo",
        "Filho(a) do responsável e do cônjuge",
        "Filho(a) somente do responsável",
        "Genro ou nora",
        "Pai, mãe, padrasto ou madrasta",
        "Sogro(a)",
        "Neto(a)",
        "Enteado(a)",
        "Irmão ou irmã",
        "Avô ou avó",
        "Empregado(a) doméstico(a)",
        "Parente do(a) empregado(a) doméstico(a)",
        "Individual em domicílio coletivo",
        "Outros"
    ]
    
    let opcoesSituacaoDomicilio = [
        "Próprio de algum morador cedido ou emprestado",
        "Ainda pagando",
        "Alugado",
        "Por empregador",
        "Por familiar",
        "Já pago, herdado ou ganho",
        "Outra forma"
    ]
    
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
                    
                    Text("2. INFORMAÇÕES SOBRE OS MORADORES")
                        .font(.system(size: 23))
                        .bold()
                        .foregroundColor(Color(red: 0.0, green: 0.3, blue: 0.3))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 7.5)
                    
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Quantas pessoas moram na residência?")
                            .font(.headline)
                            .foregroundColor(Color(red: 0.0, green: 0.3, blue: 0.3))
                        
                        LabeledTextFieldViews(title: "", text: $numeroMoradores, keyboardType: .numberPad)
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color(red: 218/255, green: 249/255, blue: 254/255))
                    .cornerRadius(20)
                    
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Nome completo, data de nascimento e sexo do entrevistado:")
                            .font(.headline)
                            .foregroundColor(Color(red: 0.0, green: 0.3, blue: 0.3))
                        
                        LabeledTextFieldViews(title: "Nome Completo", text: $nomeCompleto)
                        
                        // --------- CAMPO DE DATA -----------
                        Group {
                            if mostrandoSelecaoData {
                                VStack(spacing: 12) {
                                    Button("OK") {
                                        mostrandoSelecaoData = false
                                        dataNascimentoSelecionada = true
                                    }
                                    .padding(.bottom, 4)
                                    .font(.headline)
                                    .frame(maxWidth: .infinity)
                                    
                                    DatePicker(
                                        "",
                                        selection: $dataNascimento,
                                        displayedComponents: .date
                                    )
                                    .datePickerStyle(.wheel)
                                    .environment(\.locale, Locale(identifier: "pt_BR"))
                                    .labelsHidden()
                                }
                                .padding()
                                .background(Color(.systemGray6))
                                .cornerRadius(14)
                                .shadow(radius: 2)
                            } else {
                                Button(action: {
                                    mostrandoSelecaoData = true
                                }) {
                                    if !dataNascimentoSelecionada {
                                        Text("Clique para selecionar data")
                                            .foregroundColor(.blue)
                                            .padding(8)
                                            .frame(maxWidth: .infinity)
                                            .background(Color(.systemGray6))
                                            .cornerRadius(8)
                                    } else {
                                        Text(dateFormatter.string(from: dataNascimento))
                                            .foregroundColor(.primary)
                                            .underline()
                                            .padding(8)
                                            .frame(maxWidth: .infinity)
                                            .background(Color(.systemGray6))
                                            .cornerRadius(8)
                                    }
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                        // ------------------------------------
                        
                        RadioGroupViews(options: opcoesSexo, selected: $sexoSelecionado)
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color(red: 218/255, green: 249/255, blue: 254/255))
                    .cornerRadius(20)
                    
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Relação de parentesco com a pessoa responsável pelo domicílio")
                            .font(.headline)
                            .foregroundColor(Color(red: 0.0, green: 0.3, blue: 0.3))
                        
                        RadioGroupViews(options: opcoesParentesco, selected: $parentescoSelecionado)
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color(red: 218/255, green: 249/255, blue: 254/255))
                    .cornerRadius(20)
                    
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Este domicílio é:")
                            .font(.headline)
                            .foregroundColor(Color(red: 0.0, green: 0.3, blue: 0.3))
                        
                        RadioGroupViews(options: opcoesSituacaoDomicilio, selected: $situacaoDomicilioSelecionada)
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color(red: 218/255, green: 249/255, blue: 254/255))
                    .cornerRadius(20)
                    
                    FormNavigationButtonsRows(
                        backDestination: Question1View(),
                        nextDestination: Question3View(),
                        canProceed: !numeroMoradores.isEmpty &&
                                    !nomeCompleto.isEmpty &&
                                    dataNascimentoSelecionada &&
                                    !sexoSelecionado.isEmpty &&
                                    !parentescoSelecionado.isEmpty &&
                                    !situacaoDomicilioSelecionada.isEmpty,
                        onNext: {
                            postResposta(pergunta: "Número de moradores", resposta: numeroMoradores, descricao: "Quantidade de pessoas na residência")
                            postResposta(pergunta: "Nome completo", resposta: nomeCompleto, descricao: "Nome do entrevistado")
                            postResposta(pergunta: "Data de nascimento", resposta: dateFormatter.string(from: dataNascimento), descricao: "Data de nascimento do entrevistado")
                            postResposta(pergunta: "Sexo", resposta: sexoSelecionado, descricao: "Sexo do entrevistado")
                            postResposta(pergunta: "Parentesco", resposta: parentescoSelecionado, descricao: "Relação com o responsável")
                            postResposta(pergunta: "Situação do domicílio", resposta: situacaoDomicilioSelecionada, descricao: "Condição de moradia")
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
}

struct Question2View_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            Question2View()
        }
    }
}

