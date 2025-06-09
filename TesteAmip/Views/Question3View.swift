import SwiftUI

struct Question3View: View {
    @State private var quantidadeComodos = ""
    @State private var quantidadeDormitorios = ""
    @State private var quantidadeBanheirosCom = ""
    @State private var quantidadeBanheirosSem = ""
    @State private var acessoInternet = ""
    @State private var possuiMaquinaLavar = ""
    
    let opcoesNumericas = ["Selecione", "1", "2", "3", "4", "5", "6", "7+"]
    let opcoesSimNao = ["Sim", "Não"]
    
    var body: some View {
        VStack(spacing: 0) {
            HeaderView()
            
            ScrollView {
                VStack(spacing: 20) {
                    
                    Text("3. CARACTERÍSTICAS DO DOMICÍLIO:")
                        .font(.system(size: 23))
                        .bold()
                        .foregroundColor(Color(red: 0.0, green: 0.3, blue: 0.3))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 7.5)
                    
                    blocoPergunta(titulo: "Quantos cômodos tem esse domicílio?", selecao: $quantidadeComodos)
                    
                    blocoPergunta(titulo: "Quantos destes são dormitórios para os moradores?", selecao: $quantidadeDormitorios)
                    
                    blocoPergunta(titulo: "Quantos banheiros com chuveiro e vaso sanitário?", selecao: $quantidadeBanheirosCom)
                    
                    blocoPergunta(titulo: "Quantos banheiros sem chuveiro e com vaso sanitário?", selecao: $quantidadeBanheirosSem)
                    
                    blocoRadio(titulo: "Algum morador tem acesso à internet no domicílio?", selecao: $acessoInternet)
                    
                    blocoRadio(titulo: "A residência possui uma máquina de lavar roupa?", selecao: $possuiMaquinaLavar)
                    
                    FormNavigationButtonsRows(
                        backDestination: Question2View(),
                        nextDestination: Question4View(),
                        canProceed: quantidadeComodos != "Selecione" &&
                                    quantidadeDormitorios != "Selecione" &&
                                    quantidadeBanheirosCom != "Selecione" &&
                                    quantidadeBanheirosSem != "Selecione" &&
                                    !acessoInternet.isEmpty &&
                                    !possuiMaquinaLavar.isEmpty,
                        onNext: {
                            postResposta(pergunta: "Cômodos", resposta: quantidadeComodos, descricao: "Quantidade total de cômodos")
                            postResposta(pergunta: "Dormitórios", resposta: quantidadeDormitorios, descricao: "Número de dormitórios")
                            postResposta(pergunta: "Banheiros com chuveiro", resposta: quantidadeBanheirosCom, descricao: "Banheiros com chuveiro e vaso")
                            postResposta(pergunta: "Banheiros sem chuveiro", resposta: quantidadeBanheirosSem, descricao: "Banheiros sem chuveiro")
                            postResposta(pergunta: "Acesso à internet", resposta: acessoInternet, descricao: "Conectividade no domicílio")
                            postResposta(pergunta: "Máquina de lavar", resposta: possuiMaquinaLavar, descricao: "Presença de máquina de lavar")
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
    func blocoPergunta(titulo: String, selecao: Binding<String>) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(titulo)
                .font(.headline)
                .foregroundColor(Color(red: 0.0, green: 0.3, blue: 0.3))
                .fixedSize(horizontal: false, vertical: true)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Picker("Selecione", selection: selecao) {
                ForEach(opcoesNumericas, id: \.self) { opcao in
                    Text(opcao)
                }
            }
            .pickerStyle(MenuPickerStyle())
            .padding(8)
            .background(Color.white)
            .cornerRadius(8)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(red: 218/255, green: 249/255, blue: 254/255))
        .cornerRadius(20)
    }
    
    @ViewBuilder
    func blocoRadio(titulo: String, selecao: Binding<String>) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(titulo)
                .font(.headline)
                .foregroundColor(Color(red: 0.0, green: 0.3, blue: 0.3))
                .fixedSize(horizontal: false, vertical: true)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            RadioGroupViews(options: opcoesSimNao, selected: selecao)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(red: 218/255, green: 249/255, blue: 254/255))
        .cornerRadius(20)
    }
}

struct Question3View_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            Question3View()
        }
    }
}
