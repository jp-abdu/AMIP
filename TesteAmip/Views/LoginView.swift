import SwiftUI

struct LoginView: View {
    @State private var username = ""
    @State private var password = ""
    @State private var isLoggedIn = false
    @State private var showError = false

    var body: some View {
        NavigationView {
            ZStack {
                Color(red: 0.85, green: 1.0, blue: 1.0)
                    .ignoresSafeArea()

                VStack {
                    Spacer()
                    
                    Image("amip_logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150, height: 150)
                        .padding(.bottom, 20)

                    VStack(spacing: 20) {
                        Text("Login")
                            .font(.title)
                            .bold()
                        
                        Text("Insira os dados de login do recenseador")
                            .font(.subheadline)
                            .foregroundColor(.gray)

                        VStack(spacing: 15) {
                            HStack {
                                Text("Usuário:")
                                Spacer()
                            }
                            TextField("Insira seu email", text: $username)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .autocapitalization(.none)

                            HStack {
                                Text("Senha:")
                                Spacer()
                            }
                            SecureField("Insira sua senha", text: $password)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                        }

                        if showError {
                            Text("Usuário ou senha incorretos")
                                .foregroundColor(.red)
                                .font(.caption)
                        }

                        NavigationLink(destination: HomeView(), isActive: $isLoggedIn) {
                            Button(action: {
                                if username == "admin" && password == "12345" {
                                    isLoggedIn = true
                                } else {
                                    showError = true
                                }
                            }) {
                                Text("Entrar")
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(Color(red: 0.0, green: 0.43, blue: 0.55)) // Cor do botão igual ao print
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                            }
                        }
                    }
                    .padding(30)
                    .background(Color.white)
                    .cornerRadius(20)
                    .shadow(radius: 8)
                    .padding(.horizontal, 20)

                    Spacer()
                }
            }
        }
    }
}
