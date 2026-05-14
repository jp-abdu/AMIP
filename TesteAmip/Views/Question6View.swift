import SwiftUI

struct Question6View: View {
    @EnvironmentObject var estado: FormularioState

    let opcoesSimNao = ["Sim", "Não"]
    let opcoesQuantidadeTrabalhos = ["1", "2", "3 ou mais"]
    let faixasDeRendimento = [
        "1,00 a 500,00",
        "501,00 a 1.000,00",
        "1.001,00 a 2.000,00",
        "2.001,00 a 3.000,00",
        "3.001,00 a 5.000,00",
        "5.001,00 a 10.000,00",
        "10.001,00 a 20.000,00",
        "20.001,00 a 100.000,00",
        "100.001 ou mais"
    ]
    
    var body: some View {
        VStack(spacing: 0){
            HeaderView() // Assumindo que HeaderView já está definida
        
            ScrollView {
                VStack(spacing: 20) {
                    
                    Text("6. TRABALHO E RENDIMENTO")
                        .font(.system(size: 23))
                        .bold()
                        .foregroundColor(Color(red: 0.0, green: 0.3, blue: 0.3))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 7.5)

                    // Pergunta 1
                    FormSectionView(title: "TRABALHOU OU ESTAGIOU EM ALGUMA ATIVIDADE REMUNERADA EM DINHEIRO?") {
                        RadioGroupView(options: opcoesSimNao, selected: $estado.q6_trabalhouRemunerado)
                    }
                    .onChange(of: estado.q6_trabalhouRemunerado) { newValue in
                        // Limpa os dados de trabalho caso o usuário mude a resposta para "Não"
                        if newValue == "Não" {
                            estado.q6_quantidadeTrabalhos = ""
                            estado.q6_ocupacao = ""
                            estado.q6_atividadePrincipal = ""
                            estado.q6_carteiraAssinada = ""
                            estado.q6_possuiCNPJ = ""
                        }
                    }

                    // Condicional: Exibe as perguntas de 2 a 6 apenas se trabalhou
                    if estado.q6_trabalhouRemunerado == "Sim" {
                        // Pergunta 2
                        FormSectionView(title: "QUANTOS TRABALHOS TINHA NOS ÚLTIMOS MESES?") {
                            RadioGroupView(options: opcoesQuantidadeTrabalhos, selected: $estado.q6_quantidadeTrabalhos)
                        }

                        // Pergunta 3
                        FormSectionView(title: "QUAL ERA A OCUPAÇÃO, CARGO OU FUNÇÃO QUE TINHA NESSE TRABALHO?") {
                            LabeledTextFieldView(title: "Ex: CEO, Funcionário, etc...", text: $estado.q6_ocupacao)
                        }

                        // Pergunta 4
                        FormSectionView(title: "QUAL ERA A PRINCIPAL ATIVIDADE DO NEGÓCIO OU EMPRESA EM QUE TINHA ESSE TRABALHO?") {
                            LabeledTextFieldView(title: "Ex: Vendas, Gerenciamento, etc...", text: $estado.q6_atividadePrincipal)
                        }

                        // Pergunta 5
                        FormSectionView(title: "NESSE TRABALHO TINHA CARTEIRA DE TRABALHO ASSINADA?") {
                            RadioGroupView(options: opcoesSimNao, selected: $estado.q6_carteiraAssinada)
                        }

                        // Pergunta 6
                        FormSectionView(title: "ESSE NEGÓCIO OU EMPRESA ERA REGISTRADO NO CADASTRO NACIONAL DE PESSOA JURÍDICA - CNPJ?") {
                            RadioGroupView(options: opcoesSimNao, selected: $estado.q6_possuiCNPJ)
                        }
                    }

                    // Pergunta 7 - Sempre exibida (independente se trabalhou ou não)
                    FormSectionView(title: "FAIXA DE RENDIMENTO DO DOMICÍLIO") {
                        RadioGroupView(options: faixasDeRendimento, selected: $estado.q6_faixaRendimento)
                    }
                    
                    // Botão de próxima
                    FormNavigationButtonsRows(
                        backDestination: Question5View(),
                        nextDestination: Question7View(),
                        canProceed: isFormValid, // Usando a variável computada
                        onNext: {
                            guard let id = FormularioManager.shared.formularioId else { return }
                            APIService.shared.enviarTrabalho(
                                id: id,
                                trabalhouRemunerado: estado.q6_trabalhouRemunerado,
                                quantidadeTrabalhos: estado.q6_quantidadeTrabalhos,
                                ocupacao: estado.q6_ocupacao,
                                atividadePrincipal: estado.q6_atividadePrincipal,
                                carteiraAssinada: estado.q6_carteiraAssinada,
                                possuiCNPJ: estado.q6_possuiCNPJ,
                                faixaRendimento: estado.q6_faixaRendimento
                            )
                        }
                    )

                }
                .padding()
                .animation(.easeInOut, value: estado.q6_trabalhouRemunerado) // Transição suave ao expandir/recolher
            }
        }
        .navigationBarHidden(true)
    }
    
    // MARK: - Lógica de Validação
    private var isFormValid: Bool {
        // A faixa de rendimento e a pergunta inicial são sempre obrigatórias
        if estado.q6_trabalhouRemunerado.isEmpty || estado.q6_faixaRendimento.isEmpty {
            return false
        }
        
        // Se respondeu "Não" para trabalho, e já preencheu a renda (verificado acima), pode avançar
        if estado.q6_trabalhouRemunerado == "Não" {
            return true
        } else {
            // Se respondeu "Sim", todas as perguntas de trabalho são obrigatórias
            return !estado.q6_quantidadeTrabalhos.isEmpty &&
                   !estado.q6_ocupacao.isEmpty &&
                   !estado.q6_atividadePrincipal.isEmpty &&
                   !estado.q6_carteiraAssinada.isEmpty &&
                   !estado.q6_possuiCNPJ.isEmpty
        }
    }
}

// MARK: - Componentes Reutilizáveis

struct FormSectionView<Content: View>: View {
    let title: String
    let content: Content

    init(title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(title)
                .font(.headline)
                .foregroundColor(Color(red: 0.0, green: 0.3, blue: 0.3))

            content
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(red: 218/255, green: 249/255, blue: 254/255))
        .cornerRadius(20)
    }
}

struct LabeledTextFieldView: View {
    let title: String
    @Binding var text: String
    var keyboardType: UIKeyboardType = .default

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.subheadline)

            TextField("", text: $text)
                .keyboardType(keyboardType)
                .padding(8)
                .background(Color.white)
                .cornerRadius(8)
        }
    }
}

struct RadioGroupView: View {
    let options: [String]
    @Binding var selected: String

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            ForEach(options, id: \.self) { option in
                HStack(spacing: 12) {
                    ZStack {
                        Circle()
                            .fill(Color.white)
                            .frame(width: 25, height: 25)
                            .overlay(
                                Circle()
                                    .stroke(Color.black, lineWidth: 1)
                            )

                        if selected == option {
                            Circle()
                                .fill(Color.blue)
                                .frame(width: 10, height: 10)
                        }
                    }

                    Text(option)
                        .foregroundColor(.black)
                        .font(.system(size: 17))
                        .fixedSize(horizontal: false, vertical: true)
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    selected = option
                }
            }
        }
    }
}

struct Question6View_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            Question6View()
                .environmentObject(FormularioState())
        }
    }
}
