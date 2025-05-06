import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var senha = ""
    @State private var isLoggedIn = false

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Spacer()
                Image("amip_logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)

                Text("Login")
                    .font(.title)
                    .bold()

                TextField("Insira seu e-mail", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)

                SecureField("Insira sua senha", text: $senha)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)

                NavigationLink(destination: HomeView(), isActive: $isLoggedIn) {
                    EmptyView()
                }

                Button("Entrar") {
                    isLoggedIn = true
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
                .padding(.horizontal)

                Spacer()
            }
            .navigationBarHidden(true)
        }
    }
}
