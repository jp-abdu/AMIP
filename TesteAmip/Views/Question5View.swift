import SwiftUI

struct Question5View: View {
    @State private var possuiConjugeOuCompanheiro: String = ""
    @State private var vivemEmCompanhia: String = ""
    @State private var nomeConjugeCompanheiro: String = ""
    @State private var tipoUniao: String = ""
    
    let opcoesSimNao = ["Sim", "Não"]
    let opcoesTipoUniao = [
        "Casamento civil e religioso",
        "Só casamento civil",
        "Só casamento religioso",
        "União consensual"
    ]
    
    var body: some View {
        VStack(spacing: 0) {
            HeaderView() // Assumindo que HeaderView já está definida
            
            ScrollView {
                VStack(spacing: 20) {
                    Text("5. NUPCIALIDADE:")
                        .font(.system(size: 23))
                        .bold()
                        .foregroundColor(Color(red: 0.0, green: 0.3, blue: 0.3))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 7.5)
                    
                    // Bloco: Possui Cônjuge ou Companheiro
                    blocoRadio(titulo: "POSSUI CÔNJUGE OU COMPANHEIRO:", selecao: $possuiConjugeOuCompanheiro, opcoes: opcoesSimNao)
                    
                    // Bloco: Vivem em companhia de Cônjuge ou Companheiro
                    blocoRadio(titulo: "VIVEM EM COMPANHIA DE CÔNJUGE OU COMPANHEIRO:", selecao: $vivemEmCompanhia, opcoes: opcoesSimNao)
                    
                    // Bloco: Nome do Cônjuge/Companheiro(a)
                    blocoCampoTexto(titulo: "NOME DO CÔNJUGE/COMPANHEIRO(A)", texto: $nomeConjugeCompanheiro, placeholder: "Insira o nome:")
                    
                    // Bloco: Tipo da União
                    blocoRadio(titulo: "TIPO DA UNIÃO:", selecao: $tipoUniao, opcoes: opcoesTipoUniao)
                    
                    // Botões de navegação
                    FormNavigationButtonsRows(
                        backDestination: Question4View(),
                        nextDestination: Question6View(),
                        canProceed: !possuiConjugeOuCompanheiro.isEmpty &&
                                    !vivemEmCompanhia.isEmpty &&
                                    !nomeConjugeCompanheiro.isEmpty &&
                                    !tipoUniao.isEmpty,
                        onNext: {
                            postResposta(pergunta: "Possui cônjuge", resposta: possuiConjugeOuCompanheiro, descricao: "Se tem cônjuge ou companheiro")
                            postResposta(pergunta: "Vive em companhia", resposta: vivemEmCompanhia, descricao: "Se reside com o cônjuge")
                            postResposta(pergunta: "Nome do cônjuge", resposta: nomeConjugeCompanheiro, descricao: "Nome do cônjuge ou companheiro")
                            postResposta(pergunta: "Tipo de união", resposta: tipoUniao, descricao: "Forma de união")
                        }
                    )

                }
                .padding()
            }
        }
        .navigationBarHidden(true)
    }
    
    // MARK: - Componentes reutilizáveis (iguais aos das views anteriores, adaptados ou copiados aqui para clareza)
    
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
    func blocoCampoTexto(titulo: String, texto: Binding<String>, placeholder: String = "", keyboardType: UIKeyboardType = .default) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(titulo)
                .font(.headline)
                .foregroundColor(Color(red: 0.0, green: 0.3, blue: 0.3))
                .fixedSize(horizontal: false, vertical: true)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            LabeledTextFieldViews(title: placeholder, text: texto, keyboardType: keyboardType) // Assumindo LabeledTextFieldViews é um componente existente
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(red: 218/255, green: 249/255, blue: 254/255))
        .cornerRadius(20)
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

struct Question5View_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            Question5View()
        }
    }
}
