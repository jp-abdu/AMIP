import SwiftUI

struct Question12View: View {
    @State private var diagnosticadoComAutismo: String = ""
    
    let opcoesSimNao = ["Sim", "Não"]
    
    var body: some View {
        VStack(spacing: 0) {
            HeaderView() // Assumindo que HeaderView já está definida
            
            ScrollView {
                VStack(spacing: 20) {
                    Text("12. AUTISMO (PARA TODAS AS PESSOAS)")
                        .font(.system(size: 23))
                        .bold()
                        .foregroundColor(Color(red: 0.0, green: 0.3, blue: 0.3))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 7.5)
                    
                    // Bloco: Algum morador já foi diagnosticado(a) com autismo por algum profissional de saúde?
                    blocoRadio(
                        titulo: "ALGUM MORADOR JÁ FOI DIAGNOSTICADO(A) COM AUTISMO POR ALGUM PROFISSIONAL DE SAÚDE?",
                        selecao: $diagnosticadoComAutismo,
                        opcoes: opcoesSimNao
                    )
                    
                    // Botões de navegação
                    FormNavigationButtonsRows(
                        backDestination: Question11View(),
                        nextDestination: FormularioEnviadoView(),
                        canProceed: !diagnosticadoComAutismo.isEmpty,
                        onNext: {
                            postResposta(pergunta: "Autismo", resposta: diagnosticadoComAutismo, descricao: "Se algum morador foi diagnosticado com autismo")
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
    
    // MARK: - Componentes reutilizáveis (copiados aqui para clareza)
    
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

struct Question12View_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            Question12View()
        }
    }
}
