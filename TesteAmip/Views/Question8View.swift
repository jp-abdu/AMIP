import SwiftUI

struct Question8View: View {
    @State private var dificuldadeEnxergar: String = ""
    @State private var dificuldadeOuvir: String = ""
    @State private var dificuldadeAndar: String = ""
    
    let opcoesDificuldade = [
        "Tem, não consegue de modo algum",
        "Tem muita dificuldade",
        "Tem alguma dificuldade",
        "Não tem dificuldade"
    ]
    
    var body: some View {
        VStack(spacing: 0) {
            HeaderView() // Assumindo que HeaderView já está definida
            
            ScrollView {
                VStack(spacing: 20) {
                    Text("8. PESSOAS COM DEFICIÊNCIA (IDADE: 2 ANOS+)")
                        .font(.system(size: 23))
                        .bold()
                        .foregroundColor(Color(red: 0.0, green: 0.3, blue: 0.3))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 7.5)
                    
                    // Bloco: Dificuldade de enxergar
                    blocoRadio(
                        titulo: "TEM DIFICULDADE PERMANENTE DE ENXERGAR MESMO USANDO ÓCULOS OU LENTES DE CONTATO?",
                        selecao: $dificuldadeEnxergar,
                        opcoes: opcoesDificuldade
                    )
                    
                    // Bloco: Dificuldade de ouvir
                    blocoRadio(
                        titulo: "TEM DIFICULDADE PERMANENTE PARA OUVIR, MESMO USANDO APARELHOS AUDITIVOS?",
                        selecao: $dificuldadeOuvir,
                        opcoes: opcoesDificuldade
                    )
                    
                    // Bloco: Dificuldade de andar ou subir degraus
                    blocoRadio(
                        titulo: "TEM DIFICULDADE PERMANENTE PARA ANDAR OU SUBIR DEGRAUS, MESMO USANDO PRÓTESE, BENGALA OU APARELHO DE AUXÍLIO?",
                        selecao: $dificuldadeAndar,
                        opcoes: opcoesDificuldade
                    )
                    
                    // Botões de navegação
                    FormNavigationButtonsRows(
                        backDestination: Question7View(),
                        nextDestination: Question9View(),
                        canProceed: !dificuldadeEnxergar.isEmpty &&
                                    !dificuldadeOuvir.isEmpty &&
                                    !dificuldadeAndar.isEmpty,
                        onNext: {
                            postResposta(pergunta: "Dificuldade para enxergar", resposta: dificuldadeEnxergar, descricao: "Problema visual mesmo com correção")
                            postResposta(pergunta: "Dificuldade para ouvir", resposta: dificuldadeOuvir, descricao: "Problema auditivo mesmo com aparelhos")
                            postResposta(pergunta: "Dificuldade para andar", resposta: dificuldadeAndar, descricao: "Problema de locomoção permanente")
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
}

struct Question8View_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            Question8View()
        }
    }
}
