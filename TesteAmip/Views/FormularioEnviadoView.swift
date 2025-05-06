import SwiftUI

struct FormularioEnviadoView: View {
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack(spacing: 30) {
            Spacer()
            Text("Formulário enviado com sucesso!")
                .font(.title2)
                .bold()
                .multilineTextAlignment(.center)

            Button("Voltar à Home") {
                presentationMode.wrappedValue.dismiss() // volta à Home
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
            .padding(.horizontal)

            Spacer()
        }
        .padding()
        .background(Color(red: 0.85, green: 1.0, blue: 1.0).ignoresSafeArea())
        .navigationBarBackButtonHidden(true)
    }
}
