import SwiftUI

struct FormularioEnviadoView: View {
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack(spacing: 30) {
            Spacer()
            Image("certo")
                .resizable()
                .scaledToFit()
                .frame(height: 125) // Diminui um pouco para garantir que cabe
                .padding(.horizontal, 16)
            Text("Formulário enviado com sucesso!")
                .font(.title2)
                .bold()
                .multilineTextAlignment(.center)
            NavigationLink(destination: HomeView()) {
            Text("Voltar à Home")
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
            .padding(.horizontal)
            }

            Spacer()
        }
        .padding()
        .background(Color(red: 0.85, green: 1.0, blue: 1.0).ignoresSafeArea())
        .navigationBarBackButtonHidden(true)
    }
}

struct FormularioEnviadoView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            FormularioEnviadoView()
        }
    }
}
