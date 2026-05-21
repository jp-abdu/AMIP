import SwiftUI

struct Question10View: View {
    @EnvironmentObject var estado: FormularioState
    
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
            HeaderView()
            
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
                        titulo: "Algum morador da residência trabalha?",
                        selecao: $estado.q10_algumMoradorTrabalha,
                        opcoes: opcoesSimNao
                    )
                    .onChange(of: estado.q10_algumMoradorTrabalha) { newValue in
                        // Limpa os campos abaixo caso o usuário mude a resposta para "Não"
                        if newValue == "Não" {
                            estado.q10_municipioPaisTrabalho = ""
                            estado.q10_retornaTrabalho3DiasMais = ""
                            estado.q10_tempoDeslocamento = 0.0
                            estado.q10_meioTransporte = ""
                        }
                    }
                    
                    // A MÁGICA VISUAL ACONTECE AQUI:
                    // Só mostra o resto das perguntas se a resposta for "Sim"
                    if estado.q10_algumMoradorTrabalha == "Sim" {
                        
                        // Bloco: Em que município ou país estrangeiro trabalha?
                        blocoRadio(
                            titulo: "Em que município ou país estrangeiro trabalha?",
                            selecao: $estado.q10_municipioPaisTrabalho,
                            opcoes: opcoesMunicipioPais
                        )
                        
                        // Bloco: Retorna do trabalho para casa 3 dias ou mais na semana?
                        blocoRadio(
                            titulo: "Retorna do trabalho para casa 3 dias ou mais na semana? (Considerar a semana de 7 dias)",
                            selecao: $estado.q10_retornaTrabalho3DiasMais,
                            opcoes: opcoesSimNao
                        )
                        
                        // Bloco: Quanto tempo leva de sua casa até o local de trabalho normalmente?
                        blocoSlider(
                            titulo: "Quanto tempo leva de sua casa até o local de trabalho normalmente? (Minutos)",
                            valor: $estado.q10_tempoDeslocamento,
                            rotuloMin: "0",
                            rotuloMax: "100+",
                            legenda: "Caso não se desloque, selecionar 0"
                        )
                        
                        // Bloco: Qual o principal meio de transporte utilizado para chegar ao local de trabalho?
                        blocoRadio(
                            titulo: "Qual o principal meio de transporte utilizado para chegar ao local de trabalho?",
                            selecao: $estado.q10_meioTransporte,
                            opcoes: opcoesMeioTransporte
                        )
                    }
                    
                    // Botões de navegação
                    FormNavigationButtonsRows(
                        backDestination: Question9View(),
                        nextDestination: Question11View(),
                        canProceed: isFormValid,
                        onNext: {}
                    )
                }
                .padding()
                .animation(.easeInOut, value: estado.q10_algumMoradorTrabalha)
            }
        }
        .navigationBarHidden(true)
    }
    
    // MARK: - Lógica de Validação
    private var isFormValid: Bool {
        if estado.q10_algumMoradorTrabalha.isEmpty {
            return false
        }
        
        if estado.q10_algumMoradorTrabalha == "Não" {
            return true
        } else {
            return !estado.q10_municipioPaisTrabalho.isEmpty &&
                   !estado.q10_retornaTrabalho3DiasMais.isEmpty &&
                   !estado.q10_meioTransporte.isEmpty
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
    func blocoSlider(titulo: String, valor: Binding<Double>, rotuloMin: String, rotuloMax: String, legenda: String) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(titulo)
                .font(.headline)
                .foregroundColor(Color(red: 0.0, green: 0.3, blue: 0.3))
                .fixedSize(horizontal: false, vertical: true)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Slider(value: valor, in: 0...100, step: 1)
                .tint(Color(red: 0.0, green: 0.3, blue: 0.3))
            
            HStack {
                Text(rotuloMin)
                    .font(.caption)
                    .foregroundColor(Color(red: 0.0, green: 0.3, blue: 0.3))
                Spacer()
                Text(String(format: "%.0f", valor.wrappedValue))
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
                .frame(maxWidth: .infinity, alignment: .center)
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
                .environmentObject(FormularioState())
        }
    }
}
