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
                        .onChange(of: possuiConjugeOuCompanheiro) { newValue in
                            // Limpa os campos abaixo caso o usuário mude a resposta para "Não"
                            if newValue == "Não" {
                                vivemEmCompanhia = ""
                                nomeConjugeCompanheiro = ""
                                tipoUniao = ""
                            }
                        }
                    
                    // Condicional: Só exibe os blocos seguintes se a resposta for "Sim"
                    if possuiConjugeOuCompanheiro == "Sim" {
                        // Bloco: Vivem em companhia de Cônjuge ou Companheiro
                        blocoRadio(titulo: "VIVEM EM COMPANHIA DE CÔNJUGE OU COMPANHEIRO:", selecao: $vivemEmCompanhia, opcoes: opcoesSimNao)
                        
                        // Bloco: Nome do Cônjuge/Companheiro(a)
                        blocoCampoTexto(titulo: "NOME DO CÔNJUGE/COMPANHEIRO(A)", texto: $nomeConjugeCompanheiro, placeholder: "Insira o nome:")
                        
                        // Bloco: Tipo da União
                        blocoRadio(titulo: "TIPO DA UNIÃO:", selecao: $tipoUniao, opcoes: opcoesTipoUniao)
                    }
                    
                    // Botões de navegação
                    FormNavigationButtonsRows(
                        backDestination: Question4View(),
                        nextDestination: Question6View(),
                        canProceed: isFormValid, // Usando a variável computada para manter o código limpo
                        onNext: {
                            guard let id = FormularioManager.shared.formularioId else { return }
                            APIService.shared.enviarNupcialidade(
                                id: id,
                                possuiConjuge: possuiConjugeOuCompanheiro,
                                vivemEmCompanhia: vivemEmCompanhia,
                                nomeConjuge: nomeConjugeCompanheiro,
                                tipoUniao: tipoUniao
                            )
                        }
                    )
                }
                .padding()
                .animation(.easeInOut, value: possuiConjugeOuCompanheiro) // Adiciona uma transição suave ao mostrar/esconder campos
            }
        }
        .navigationBarHidden(true)
    }
    
    // MARK: - Lógica de Validação
    private var isFormValid: Bool {
        if possuiConjugeOuCompanheiro.isEmpty {
            return false
        } else if possuiConjugeOuCompanheiro == "Não" {
            return true // Pode avançar se marcou "Não"
        } else {
            // Se marcou "Sim", todos os outros campos são obrigatórios
            return !vivemEmCompanhia.isEmpty &&
                   !nomeConjugeCompanheiro.isEmpty &&
                   !tipoUniao.isEmpty
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
        }
    }
}
