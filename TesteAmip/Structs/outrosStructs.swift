import SwiftUI
//tava dando problema com o nome botei um s no final desse struct, sepa todos os structs temq ter nome diferente

var body: some View {
    ScrollView {
        VStack(spacing: 20) {

            // Pergunta 1
            FormSectionView(title: "TRABALHOU OU ESTAGIOU EM ALGUMA ATIVIDADE REMUNERADA EM DINHEIRO?") {
                RadioGroupView(options: opcoesSimNao, selected: $trabalhouRemunerado)
            }

            // Pergunta 2
            FormSectionView(title: "QUANTOS TRABALHOS TINHA NOS ÚLTIMOS MESES?") {
                RadioGroupView(options: opcoesQuantidadeTrabalhos, selected: $quantidadeTrabalhos)
            }

            // Pergunta 3
            FormSectionView(title: "QUAL ERA A OCUPAÇÃO, CARGO OU FUNÇÃO QUE TINHA NESSE TRABALHO?") {
                LabeledTextFieldView(title: "Ex: CEO, Funcionário, etc...", text: $ocupacao)
            }

            // Pergunta 4
            FormSectionView(title: "QUAL ERA A PRINCIPAL ATIVIDADE DO NEGÓCIO OU EMPRESA EM QUE TINHA ESSE TRABALHO?") {
                LabeledTextFieldView(title: "Ex: Vendas, Gerenciamento, etc...", text: $atividadePrincipal)
            }

            // Pergunta 5
            FormSectionView(title: "NESSE TRABALHO TINHA CARTEIRA DE TRABALHO ASSINADA?") {
                RadioGroupView(options: opcoesSimNao, selected: $carteiraAssinada)
            }

            // Pergunta 6
            FormSectionView(title: "ESSE NEGÓCIO OU EMPRESA ERA REGISTRADO NO CADASTRO NACIONAL DE PESSOA JURÍDICA - CNPJ?") {
                RadioGroupView(options: opcoesSimNao, selected: $possuiCNPJ)
            }

            // Pergunta 7
            FormSectionView(title: "FAIXA DE RENDIMENTO") {
                RadioGroupView(options: faixasDeRendimento, selected: $faixaRendimento)
                
                
struct LabeledTextFieldViews: View {
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

//tava dando problema com o nome botei um s no final desse struct, sepa todos os structs temq ter nome diferente
struct RadioGroupViews: View {
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
