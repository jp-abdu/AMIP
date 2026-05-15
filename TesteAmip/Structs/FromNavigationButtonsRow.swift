import SwiftUI

struct FormNavigationButtonsRows<BackDestination: View, NextDestination: View>: View {
    @EnvironmentObject var estado: FormularioState
    
    // NOVO: Essa variável é a responsável por fechar a tela atual e voltar de verdade!
    @Environment(\.presentationMode) var presentationMode
    
    let backDestination: BackDestination
    let nextDestination: NextDestination
    let backLabel: String
    let nextLabel: String
    let canProceed: Bool
    let onNext: () -> Void

    @State private var navigate = false
    @State private var showingAlert = false
    @State private var showingCancelDialog = false
    @State private var processandoSaida = false

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
                
                // NOVO BOTÃO VOLTAR (Agora volta de verdade, apagando a tela atual da memória)
                Button(action: {
                    if BackDestination.self == HomeView.self {
                        // Se for a Q1 (destino seria Home), abre o menu de saída em vez de voltar
                        showingCancelDialog = true
                    } else {
                        // Se for da Q2 em diante, apenas destrói a tela atual (volta 1 passo)
                        presentationMode.wrappedValue.dismiss()
                    }
                }) {
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
                .disabled(processandoSaida)

                // Este NavigationLink (Avançar) continua igual, ele empurra para frente corretamente
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
                .disabled(processandoSaida)
                .alert(isPresented: $showingAlert) {
                    Alert(
                        title: Text("Atenção"),
                        message: Text("Por favor, preencha todas as respostas antes de continuar."),
                        dismissButton: .default(Text("OK"))
                    )
                }
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
        
        // MENU INFERIOR DE CANCELAMENTO
        .confirmationDialog("Opções de Cancelamento", isPresented: $showingCancelDialog, titleVisibility: .visible) {
            
            Button("Salvar incompleto e Sair") {
                processandoSaida = true
                // Deixa a animação do menu terminar antes de acionar a API
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    estado.salvarFormularioNoBackend(finalizar: false) { _ in
                        encerrarENavegar()
                    }
                }
            }
            
            Button("Sair sem salvar (Descartar)", role: .destructive) {
                processandoSaida = true
                // Aumentamos o atraso para 0.8s para garantir que o menu desapareceu 100%
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                    encerrarENavegar()
                }
            }
            
            Button("Cancelar", role: .cancel) { }
            
        } message: {
            Text("O formulário ainda não foi concluído. O que deseja fazer?")
        }
    }
    
    // Função auxiliar super limpa (Pop To Root)
    private func encerrarENavegar() {
        FormularioManager.shared.formularioId = nil
        processandoSaida = false
        // Desliga a raiz, voltando para a Home instantaneamente sem "empilhar" telas
        estado.isFormularioAtivo = false
    }
}
