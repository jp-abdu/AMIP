import SwiftUI

struct FormNavigationButtonsRows<BackDestination: View, NextDestination: View>: View {
    @EnvironmentObject var estado: FormularioState
    
    let backDestination: BackDestination
    let nextDestination: NextDestination
    let backLabel: String
    let nextLabel: String
    let canProceed: Bool
    let onNext: () -> Void

    @State private var navigate = false
    @State private var showingAlert = false
    @State private var showingCancelAlert = false // NOVO: Controle do alerta de cancelamento
    @State private var navigateToHome = false // NOVO: Controle de navegação para a Home

    init(
        backLabel: String = "Voltar",
        nextLabel: String = "Próxima",
        backDestination: BackDestination,
        nextDestination: NextDestination,
        canProceed: Bool,
        onNext: @escaping () -> Void
    ) {
        self.backLabel = backLabel
        self.nextLabel = nextLabel
        self.backDestination = backDestination
        self.nextDestination = nextDestination
        self.canProceed = canProceed
        self.onNext = onNext
    }

    var body: some View {
        Spacer()
        VStack(alignment: .leading, spacing: 5) {
            HStack(spacing: 10) {
                
                // BOTÃO VOLTAR
                NavigationLink(destination: backDestination) {
                    Text(backLabel)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .foregroundColor(Color(red: 0/255, green: 104/255, blue: 150/255))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color(red: 0/255, green: 104/255, blue: 150/255), lineWidth: 1.8)
                        )
                        .cornerRadius(10)
                }
                .simultaneousGesture(TapGesture().onEnded {
                    // Se estiver voltando para a Home (na Q1), mostra o alerta em vez de limpar direto
                    if BackDestination.self == HomeView.self {
                        showingCancelAlert = true
                    }
                })

                NavigationLink(destination: nextDestination, isActive: $navigate) {
                    EmptyView()
                }

                // BOTÃO AVANÇAR
                Button(action: {
                    if canProceed {
                        onNext()
                        navigate = true
                    } else {
                        showingAlert = true
                    }
                }) {
                    Text(nextLabel)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(red: 0/255, green: 104/255, blue: 150/255))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .alert(isPresented: $showingAlert) {
                    Alert(
                        title: Text("Atenção"),
                        message: Text("Por favor, preencha todas as respostas antes de continuar."),
                        dismissButton: .default(Text("OK"))
                    )
                }
            }

            // Link oculto para disparar a volta para a Home via código
            NavigationLink(destination: HomeView(), isActive: $navigateToHome) {
                EmptyView()
            }

            // BOTÃO RETORNAR AO HOME (CANCELA O FORMULÁRIO)
            Button(action: {
                showingCancelAlert = true
            }) {
                Text("Retornar ao Home")
                    .foregroundColor(Color(red: 0/255, green: 104/255, blue: 150/255))
                    .underline(true, color: Color(red: 0/255, green: 104/255, blue: 150/255))
            }
            .alert(isPresented: $showingCancelAlert) {
                            Alert(
                                title: Text("Atenção"),
                                message: Text("Tem certeza que deseja sair? Você pode salvar os dados coletados até aqui como um formulário incompleto."),
                                primaryButton: .default(Text("Salvar e Sair")) {
                                    // 1. Envia tudo que o usuário já respondeu
                                    if let id = FormularioManager.shared.formularioId {
                                        estado.enviarDadosParaAPI(formularioId: id)
                                    }
                                    
                                    // 2. Limpa memória e volta pro menu
                                    encerrarENavegar()
                                },
                                secondaryButton: .destructive(Text("Sair sem Salvar")) {
                                    // Limpa a memória ignorando os dados e vai para a Home
                                    encerrarENavegar()
                                }
                            )
                        }
        }
        .padding(.horizontal)
    }
    
    // Função auxiliar para evitar repetição de código
    private func encerrarENavegar() {
        estado.limparFormulario()
        FormularioManager.shared.formularioId = nil
        navigateToHome = true
    }
}
