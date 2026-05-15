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
    @State private var showingCancelDialog = false // Controla o novo menu de opções
    @State private var navigateToHome = false
    @State private var processandoSaida = false // Controla o carregamento visual

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
                .disabled(processandoSaida) // Trava o botão durante o carregamento
                .simultaneousGesture(TapGesture().onEnded {
                    // Se o botão voltar apontar para a Home (Question1), aciona o menu
                    if BackDestination.self == HomeView.self {
                        showingCancelDialog = true
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
                .disabled(processandoSaida) // Trava o botão durante o carregamento
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

            // BOTÃO RETORNAR AO HOME / CARREGAMENTO
            if processandoSaida {
                HStack {
                    ProgressView()
                        .padding(.trailing, 8)
                    Text("Processando saída...")
                        .foregroundColor(.gray)
                }
                .padding(.top, 8)
                .frame(maxWidth: .infinity, alignment: .leading)
            } else {
                Button(action: {
                    showingCancelDialog = true
                }) {
                    Text("Retornar ao Home")
                        .foregroundColor(Color(red: 0/255, green: 104/255, blue: 150/255))
                        .underline(true, color: Color(red: 0/255, green: 104/255, blue: 150/255))
                }
                .padding(.top, 8)
            }
        }
        .padding(.horizontal)
        // MENU INFERIOR DE CANCELAMENTO (Confirmation Dialog suporta 3 opções nativas)
        .confirmationDialog("Opções de Cancelamento", isPresented: $showingCancelDialog, titleVisibility: .visible) {
            
            Button("Salvar incompleto e Sair") {
                processandoSaida = true
                // Atraso de 0.5s para a animação do menu terminar antes de bater na API
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    estado.salvarFormularioNoBackend(finalizar: false) { _ in
                        encerrarENavegar()
                    }
                }
            }
            
            Button("Sair sem salvar (Descartar)", role: .destructive) {
                navigateToHome = true
            }
            
            // Botão Cancelar: apenas fecha o menu e deixa o usuário na página
            Button("Cancelar", role: .cancel) { }
            
        } message: {
            Text("O formulário ainda não foi concluído. O que deseja fazer?")
        }
    }
    
    //encerrar navegacao
    private func encerrarENavegar() {
            // Removemos o ID
            FormularioManager.shared.formularioId = nil
            
            // IMPORTANTE: Damos um tempo maior (0.6s) para o menu (ConfirmationDialog)
            // sumir completamente. Isso evita o erro de "existing transition" no terminal.
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                self.processandoSaida = false
                self.navigateToHome = true
            }
        }
}
