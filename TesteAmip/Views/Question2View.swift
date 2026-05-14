import SwiftUI

struct Question2View: View {
    @EnvironmentObject var estado: FormularioState
    
    // Variável local apenas para controle de interface (não precisa ir para a API)
    @State private var mostrandoSelecaoData = false
    
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
                        
                        LabeledTextFieldViews(title: "", text: $estado.q2_numeroMoradores, keyboardType: .numberPad)
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color(red: 218/255, green: 249/255, blue: 254/255))
                    .cornerRadius(20)
                    // Atualiza a quantidade de DatePickers com base no número digitado
                    .onChange(of: estado.q2_numeroMoradores) { newValue in
                        let total = Int(newValue) ?? 1
                        let qtdAdicionais = max(0, total - 1)
                        
                        if estado.q2_datasAdicionais.count < qtdAdicionais {
                            let difference = qtdAdicionais - estado.q2_datasAdicionais.count
                            estado.q2_datasAdicionais.append(contentsOf: Array(repeating: Date(), count: difference))
                        } else if estado.q2_datasAdicionais.count > qtdAdicionais {
                            estado.q2_datasAdicionais.removeLast(estado.q2_datasAdicionais.count - qtdAdicionais)
                        }
                    }
                    
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Nome completo, data de nascimento e sexo do entrevistado:")
                            .font(.headline)
                            .foregroundColor(Color(red: 0.0, green: 0.3, blue: 0.3))
                        
                        LabeledTextFieldViews(title: "Nome Completo", text: $estado.q2_nomeCompleto)
                        
                        // --------- CAMPO DE DATA DA PESSOA 1 -----------
                        Group {
                            if mostrandoSelecaoData {
                                VStack(spacing: 12) {
                                    Button("OK") {
                                        mostrandoSelecaoData = false
                                        estado.q2_dataNascimentoSelecionada = true
                                    }
                                    .padding(.bottom, 4)
                                    .font(.headline)
                                    .frame(maxWidth: .infinity)
                                    
                                    DatePicker(
                                        "",
                                        selection: $estado.q2_dataNascimento,
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
                                    if !estado.q2_dataNascimentoSelecionada {
                                        Text("Clique para selecionar data")
                                            .foregroundColor(.blue)
                                            .padding(8)
                                            .frame(maxWidth: .infinity)
                                            .background(Color(.systemGray6))
                                            .cornerRadius(8)
                                    } else {
                                        Text(dateFormatter.string(from: estado.q2_dataNascimento))
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
                        
                        RadioGroupViews(options: opcoesSexo, selected: $estado.q2_sexoSelecionado)
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color(red: 218/255, green: 249/255, blue: 254/255))
                    .cornerRadius(20)
                    
                    // Renderiza os DatePickers para os moradores adicionais
                    if estado.q2_datasAdicionais.count > 0 {
                        VStack(alignment: .leading, spacing: 16) {
                            Text("Data de nascimento dos outros moradores:")
                                .font(.headline)
                                .foregroundColor(Color(red: 0.0, green: 0.3, blue: 0.3))
                            
                            ForEach(0..<estado.q2_datasAdicionais.count, id: \.self) { index in
                                HStack {
                                    Text("Morador \(index + 2)")
                                        .font(.subheadline)
                                    
                                    Spacer()
                                    
                                    DatePicker(
                                        "",
                                        selection: $estado.q2_datasAdicionais[index],
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
                        .animation(.easeInOut, value: estado.q2_datasAdicionais.count)
                    }
                    
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Relação de parentesco com a pessoa responsável pelo domicílio")
                            .font(.headline)
                            .foregroundColor(Color(red: 0.0, green: 0.3, blue: 0.3))
                        
                        RadioGroupViews(options: opcoesParentesco, selected: $estado.q2_parentescoSelecionado)
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color(red: 218/255, green: 249/255, blue: 254/255))
                    .cornerRadius(20)
                    
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Este domicílio é:")
                            .font(.headline)
                            .foregroundColor(Color(red: 0.0, green: 0.3, blue: 0.3))
                        
                        RadioGroupViews(options: opcoesSituacaoDomicilio, selected: $estado.q2_situacaoDomicilioSelecionada)
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color(red: 218/255, green: 249/255, blue: 254/255))
                    .cornerRadius(20)
                    
                    FormNavigationButtonsRows(
                        backDestination: Question1View(),
                        nextDestination: Question3View(),
                        canProceed: !estado.q2_numeroMoradores.isEmpty &&
                                    !estado.q2_nomeCompleto.isEmpty &&
                                    estado.q2_dataNascimentoSelecionada &&
                                    !estado.q2_sexoSelecionado.isEmpty &&
                                    !estado.q2_parentescoSelecionado.isEmpty &&
                                    !estado.q2_situacaoDomicilioSelecionada.isEmpty,
                        onNext: {
                            guard let id = FormularioManager.shared.formularioId else { return }

                            // Converte os Dates gerados na UI para Strings no formato dd/MM/yyyy
                            estado.q2_datasNascimentoMoradores = estado.q2_datasAdicionais.map { dateFormatter.string(from: $0) }

                            // Monta o array com todas as datas (incluindo a do responsável)
                            var todasAsDatas = [dateFormatter.string(from: estado.q2_dataNascimento)]
                            todasAsDatas.append(contentsOf: estado.q2_datasNascimentoMoradores)

                            APIService.shared.enviarMoradores(
                                id: id,
                                numeroMoradores: Int(estado.q2_numeroMoradores) ?? 1,
                                nomeCompleto: estado.q2_nomeCompleto,
                                dataNascimento: dateFormatter.string(from: estado.q2_dataNascimento),
                                datasNascimentoMoradores: todasAsDatas, // Envia o array conforme sua nova implementação
                                sexo: estado.q2_sexoSelecionado,
                                parentesco: estado.q2_parentescoSelecionado,
                                situacaoDomicilio: estado.q2_situacaoDomicilioSelecionada
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
                .environmentObject(FormularioState())
        }
    }
}
