import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack(spacing: 20) {
            Image("amip_logo")
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)

            Text("Olá! Seja muito bem-vindo(a)!")
                .font(.title2)
                .bold()

            Text("Abaixo você pode encontrar o questionário:")
                .font(.subheadline)

            Image(systemName: "doc.text")
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)

            NavigationLink(destination: Question1View()) {
                Text("Iniciar")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.horizontal)

            Spacer()
        }
        .padding()
        .navigationTitle("Tela Inicial")
    }
}
