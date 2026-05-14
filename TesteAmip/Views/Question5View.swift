import SwiftUI

struct Question5View: View {
    @EnvironmentObject var estado: FormularioState
     
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
                    blocoRadio(
                        titulo: "POSSUI CÔNJUGE OU COMPANHEIRO:",
                        selecao: $estado.q5_possuiConjugeOuCompanheiro,
                        opcoes: opcoesSimNao
                    )
                    .onChange(of: estado.q5_possuiConjugeOuCompanheiro) { newValue in
                        // Limpa os campos abaixo caso o usuário mude a resposta para "Não"
                        if newValue == "Não" {
                            estado.q5_vivemEmCompanhia = ""
                            estado.q5_nomeConjugeCompanheiro = ""
                            estado.q5_tipoUniao = ""
                        }
                    }
                    
                    // Condicional: Só exibe os blocos seguintes se a resposta for "Sim"
                    if estado.q5_possuiConjugeOuCompanheiro == "Sim" {
                        // Bloco: Vivem em companhia de Cônjuge ou Companheiro
                        blocoRadio(
                            titulo: "VIVEM EM COMPANHIA DE CÔNJUGE OU COMPANHEIRO:",
                            selecao: $estado.q5_vivemEmCompanhia,
                            opcoes: opcoesSimNao
                        )
                        
                        // Bloco: Nome do Cônjuge/Companheiro(a)
                        blocoCampoTexto(
                            titulo: "NOME DO CÔNJUGE/COMPANHEIRO(A)",
                            texto: $estado.q5_nomeConjugeCompanheiro,
                            placeholder: "Insira o nome:"
                        )
                        
                        // Bloco: Tipo da União
                        blocoRadio(
                            titulo: "TIPO DA UNIÃO:",
                            selecao: $estado.q5_tipoUniao,
                            opcoes: opcoesTipoUniao
                        )
                    }
                    
                    // Botões de navegação
                    FormNavigationButtonsRows(
                        backDestination: Question4View(),
                        nextDestination: Question6View(),
                        canProceed: isFormValid, // Usando a variável computada para manter o código limpo
                        onNext: {}
                    )
                }
                .padding()
                .animation(.easeInOut, value: estado.q5_possuiConjugeOuCompanheiro) // Adiciona uma transição suave ao mostrar/esconder campos
            }
        }
        .navigationBarHidden(true)
    }
    
    // MARK: - Lógica de Validação
    private var isFormValid: Bool {
        if estado.q5_possuiConjugeOuCompanheiro.isEmpty {
            return false
        } else if estado.q5_possuiConjugeOuCompanheiro == "Não" {
            return true // Pode avançar se marcou "Não"
        } else {
            // Se marcou "Sim", todos os outros campos são obrigatórios
            return !estado.q5_vivemEmCompanhia.isEmpty &&
                   !estado.q5_nomeConjugeCompanheiro.isEmpty &&
                   !estado.q5_tipoUniao.isEmpty
        }
    }
    
    // MARK: - Componentes reutilizáveis
    
    @ViewBuilder
    func blocoRadio(titulo: String, selecao: Binding<String>, opcoes: [String]) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(titulo)
                .font(.headline)
                .foregroundColor(Color(red: 0.0, green: 0.3, blue: 0.3))
                .fixedSize(horizontal: false, vertical: true)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            RadioGroupViews(options: opcoes, selected: selecao)
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
            
            LabeledTextFieldViews(title: placeholder, text: texto, keyboardType: keyboardType)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(red: 218/255, green: 249/255, blue: 254/255))
        .cornerRadius(20)
    }
}

struct Question5View_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            Question5View()
                .environmentObject(FormularioState())
        }
    }
}
