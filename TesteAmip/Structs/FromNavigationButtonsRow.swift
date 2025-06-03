    import SwiftUI

    struct FormNavigationButtonsRows<BackDestination: View, NextDestination: View>: View {
        let backDestination: BackDestination
        let nextDestination: NextDestination
        let backLabel: String
        let nextLabel: String

        init(
            backLabel: String = "Voltar",
            nextLabel: String = "Próxima",
            backDestination: BackDestination,
            nextDestination: NextDestination
        ) {
            self.backLabel = backLabel
            self.nextLabel = nextLabel
            self.backDestination = backDestination
            self.nextDestination = nextDestination
        }

        var body: some View {
            Spacer()
            VStack(alignment: .leading, spacing: 5) {
                HStack(spacing: 10) {
                    // Botão Voltar
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

                    // Botão Finalizar
                    NavigationLink(destination: nextDestination) {
                        Text(nextLabel)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color(red: 0/255, green: 104/255, blue: 150/255))
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }

                // Link para a Home
                NavigationLink(destination: HomeView()) {
                    Text("Retornar ao Home")
                        .foregroundColor(Color(red: 0/255, green: 104/255, blue: 150/255))
                        .underline(true, color: Color(red: 0/255, green: 104/255, blue: 150/255))
                }
            }
            .padding(.horizontal)
        }
    }
