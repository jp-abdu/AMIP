import SwiftUI

struct Question10View: View {
    @State private var algumMoradorTrabalha: String = ""
    @State private var municipioPaisTrabalho: String = ""
    @State private var retornaTrabalho3DiasMais: String = ""
    @State private var tempoDeslocamento: Double = 0.0 // Para o Slider
    @State private var meioTransporte: String = ""
    
    let opcoesSimNao = ["Sim", "Não"]
    let opcoesMunicipioPais = [
        "Apenas em casa ou na propriedade/neste município",
        "Fora de casa, da propriedade/neste município",
        "Em outro município do Brasil",
        "Em outro país",
        "Em mais de um município ou país"
    ]
    let opcoesMeioTransporte = [
        "A pé",
        "Bicicleta",
        "Motocicleta",
        "Automóvel",
        "Táxi ou assemelhados",
        "Van ou assemelhados",
        "Embarcação de médio e grande porte (acima de 20 pessoas)",
        "Embarcação de pequeno porte (até 20 pessoas)",
        "Outros"
    ]
    
    var body: some View {
        VStack(spacing: 0) {
            HeaderView() // Assumindo que HeaderView já está definida
            
            ScrollView {
                VStack(spacing: 20) {
                    Text("10. DESLOCAMENTO PARA TRABALHO (PARA PESSOA QUE TRABALHA)")
                        .font(.system(size: 23))
                        .bold()
                        .foregroundColor(Color(red: 0.0, green: 0.3, blue: 0.3))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 7.5)
                    
                    // Bloco: Algum morador da residência trabalha?
                    blocoRadio(
                        titulo: "ALGUM MORADOR DA RESIDÊNCIA TRABALHA?",
                        selecao: $algumMoradorTrabalha,
                        opcoes: opcoesSimNao
                    )
                    
                    // Bloco: Em que município ou país estrangeiro trabalha?
                    blocoRadio(
                        titulo: "EM QUE MUNICÍPIO OU PAÍS ESTRANGEIRO TRABALHA?",
                        selecao: $municipioPaisTrabalho,
                        opcoes: opcoesMunicipioPais
                    )
                    
                    // Bloco: Retorna do trabalho para casa 3 dias ou mais na semana?
                    blocoRadio(
                        titulo: "RETORNA DO TRABALHO PARA CASA 3 DIAS OU MAIS NA SEMANA? (Considerar a semana de 7 dias)",
                        selecao: $retornaTrabalho3DiasMais,
                        opcoes: opcoesSimNao
                    )
                    
                    // Bloco: Quanto tempo leva de sua casa até o local de trabalho normalmente?
                    blocoSlider(
                        titulo: "QUANTO TEMPO LEVA DE SUA CASA ATÉ O LOCAL DE TRABALHO NORMALMENTE?(Minutos)",
                        valor: $tempoDeslocamento,
                        rotuloMin: "0",
                        rotuloMax: "100+",
                        legenda: "Caso não se desloque, selecionar 0"
                    )
                    
                    // Bloco: Qual o principal meio de transporte utilizado para chegar ao local de trabalho?
                    blocoRadio(
                        titulo: "QUAL O PRINCIPAL MEIO DE TRANSPORTE UTILIZADO PARA CHEGAR AO LOCAL DE TRABALHO?",
                        selecao: $meioTransporte,
                        opcoes: opcoesMeioTransporte
                    )
                    
                    // Botões de navegação
                    FormNavigationButtonsRows(
                        backDestination: Question9View(),
                        nextDestination: Question11View(),
                        canProceed: !algumMoradorTrabalha.isEmpty &&
                                    !municipioPaisTrabalho.isEmpty &&
                                    !retornaTrabalho3DiasMais.isEmpty &&
                                    !meioTransporte.isEmpty,
                        onNext: {
                            postResposta(pergunta: "Algum morador trabalha", resposta: algumMoradorTrabalha, descricao: "Se há moradores com trabalho")
                            postResposta(pergunta: "Município ou país do trabalho", resposta: municipioPaisTrabalho, descricao: "Local onde o morador trabalha")
                            postResposta(pergunta: "Retorna do trabalho 3 dias ou mais", resposta: retornaTrabalho3DiasMais, descricao: "Frequência de retorno para casa")
                            postResposta(pergunta: "Tempo de deslocamento", resposta: String(format: "%.0f", tempoDeslocamento), descricao: "Tempo em minutos até o trabalho")
                            postResposta(pergunta: "Meio de transporte", resposta: meioTransporte, descricao: "Principal meio utilizado para trabalhar")
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
    
    // MARK: - Componentes reutilizáveis (adaptados ou copiados aqui para clareza)
    
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
    func blocoSlider(titulo: String, valor: Binding<Double>, rotuloMin: String, rotuloMax: String, legenda: String) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(titulo)
                .font(.headline)
                .foregroundColor(Color(red: 0.0, green: 0.3, blue: 0.3))
                .fixedSize(horizontal: false, vertical: true)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Slider(value: valor, in: 0...100, step: 1) // Ajuste o 'in' e 'step' conforme sua necessidade, 100 pode ser o max de minutos
                .tint(Color(red: 0.0, green: 0.3, blue: 0.3)) // Cor do slider
            
            HStack {
                Text(rotuloMin)
                    .font(.caption)
                    .foregroundColor(Color(red: 0.0, green: 0.3, blue: 0.3))
                Spacer()
                Text(String(format: "%.0f", valor.wrappedValue)) // Mostra o valor atual
                    .font(.caption)
                    .foregroundColor(Color(red: 0.0, green: 0.3, blue: 0.3))
                Spacer()
                Text(rotuloMax)
                    .font(.caption)
                    .foregroundColor(Color(red: 0.0, green: 0.3, blue: 0.3))
            }
            .padding(.horizontal, 4)
            
            Text(legenda)
                .font(.caption)
                .foregroundColor(Color(red: 0.0, green: 0.3, blue: 0.3))
                .frame(maxWidth: .infinity, alignment: .center) // Centraliza a legenda
                .padding(.top, 4)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(red: 218/255, green: 249/255, blue: 254/255))
        .cornerRadius(20)
    }
}

struct Question10View_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            Question10View()
        }
    }
}
