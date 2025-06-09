import SwiftUI

struct FormNavigationButtonsRows<BackDestination: View, NextDestination: View>: View {
    let backDestination: BackDestination
    let nextDestination: NextDestination
    let backLabel: String
    let nextLabel: String
    let canProceed: Bool
    let onNext: () -> Void

    @State private var navigate = false
    @State private var showingAlert = false

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

                NavigationLink(destination: nextDestination, isActive: $navigate) {
                    EmptyView()
                }

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
                    Alert(title: Text("Atenção"), message: Text("Por favor, preencha todas as respostas antes de continuar."), dismissButton: .default(Text("OK")))
                }
            }

            NavigationLink(destination: HomeView()) {
                Text("Retornar ao Home")
                    .foregroundColor(Color(red: 0/255, green: 104/255, blue: 150/255))
                    .underline(true, color: Color(red: 0/255, green: 104/255, blue: 150/255))
            }
        }
        .padding(.horizontal)
    }
}
