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
    @State private var datasNascimentoMoradores: [String] = []
    
    // NOVO: Array de Dates para fazer o binding com os DatePickers gerados dinamicamente
    @State private var datasAdicionais: [Date] = []
    
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
                    // NOVO: Atualiza a quantidade de DatePickers com base no número digitado
                    .onChange(of: numeroMoradores) { newValue in
                        let total = Int(newValue) ?? 1
                        // Subtraímos 1 assumindo que o total inclui o entrevistado.
                        // Ex: Se moram 3, criará 2 campos extras. Se a regra for diferente, mude para: let qtdAdicionais = total
                        let qtdAdicionais = max(0, total - 1)
                        
                        if datasAdicionais.count < qtdAdicionais {
                            let difference = qtdAdicionais - datasAdicionais.count
                            datasAdicionais.append(contentsOf: Array(repeating: Date(), count: difference))
                        } else if datasAdicionais.count > qtdAdicionais {
                            datasAdicionais.removeLast(datasAdicionais.count - qtdAdicionais)
                        }
                    }
                    
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Nome completo, data de nascimento e sexo do entrevistado:")
                            .font(.headline)
                            .foregroundColor(Color(red: 0.0, green: 0.3, blue: 0.3))
                        
                        LabeledTextFieldViews(title: "Nome Completo", text: $nomeCompleto)
                        
                        // --------- CAMPO DE DATA DA PESSOA 1 -----------
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
                    
                    // NOVO: Renderiza os DatePickers para os moradores adicionais
                    if datasAdicionais.count > 0 {
                        VStack(alignment: .leading, spacing: 16) {
                            Text("Data de nascimento dos outros moradores:")
                                .font(.headline)
                                .foregroundColor(Color(red: 0.0, green: 0.3, blue: 0.3))
                            
                            ForEach(0..<datasAdicionais.count, id: \.self) { index in
                                HStack {
                                    Text("Morador \(index + 2)")
                                        .font(.subheadline)
                                    
                                    Spacer()
                                    
                                    DatePicker(
                                        "",
                                        selection: $datasAdicionais[index],
                                        displayedComponents: .date
                                    )
                                    .labelsHidden()
                                    .environment(\.locale, Locale(identifier: "pt_BR"))
                                }
                                Divider()
                            }
                        }
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color(red: 218/255, green: 249/255, blue: 254/255))
                        .cornerRadius(20)
                        .animation(.easeInOut, value: datasAdicionais.count) // Transição suave ao adicionar/remover
                    }
                    
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
                            guard let id = FormularioManager.shared.formularioId else { return }

                            // NOVO: Converte os Dates gerados na UI para Strings no formato dd/MM/yyyy
                            datasNascimentoMoradores = datasAdicionais.map { dateFormatter.string(from: $0) }

                            // Monta o array com todas as datas (incluindo a do responsável)
                            var todasAsDatas = [dateFormatter.string(from: dataNascimento)]
                            todasAsDatas.append(contentsOf: datasNascimentoMoradores)

                            APIService.shared.enviarMoradores(
                                id: id,
                                numeroMoradores: Int(numeroMoradores) ?? 1,
                                nomeCompleto: nomeCompleto,
                                dataNascimento: dateFormatter.string(from: dataNascimento),
                                datasNascimentoMoradores: todasAsDatas,
                                sexo: sexoSelecionado,
                                parentesco: parentescoSelecionado,
                                situacaoDomicilio: situacaoDomicilioSelecionada
                            )
                        }
                    )

                }
                .padding()
            }
        }
        .navigationBarHidden(true)
    }
}

struct Question2View_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            Question2View()
        }
    }
}
