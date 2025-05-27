import SwiftUI
//tava dando problema com o nome botei um s no final desse, sepa todos os structs temq ter nome diferente

struct FormNavigationButtonsRows<BackDestination: View, NextDestination: View>: View {
    let backLabel: String
    let nextLabel: String
    let backDestination: BackDestination
    let nextDestination: NextDestination

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

            // Botão Próxima
            NavigationLink(destination: nextDestination) {
                Text(nextLabel)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color(red: 0/255, green: 107/255, blue: 140/255))
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .padding(.top)
    }
}
