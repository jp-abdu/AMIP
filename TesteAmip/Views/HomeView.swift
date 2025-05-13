import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Color.white
                    .ignoresSafeArea()

                VStack(spacing: 20) {
                    // Logo mais para o topo
                    Image("amip_logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150, height: 150)
                        .padding(.top, 20) // Reduzi o padding para subir a logo

                    // Textos de boas-vindas
                    Text("Olá! Seja muito bem-vindo(a)!")
                        .font(.title)
                        .bold()
                        .multilineTextAlignment(.center)

                    Text("Abaixo você pode encontrar o questionário:")
                        .font(.subheadline)
                        .foregroundColor(.gray)

                    Spacer() // Para centralizar a caixa

                    // Caixa centralizada com borda
                    VStack {
                        Text("Recenseamento Ilha Primeira")
                            .font(.headline)
                            .padding(.top, 10)

                        Image("census_image")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200, height: 200)
                            .padding(.vertical, 10)

                        HStack {
                            VStack(alignment: .leading) {
                                Text("Recenseamento")
                                    .font(.subheadline)
                                Text("Menos de 15 minutos")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }

                            Spacer()

                            NavigationLink(destination: Question1View()) {
                                Text("Iniciar")
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 8)
                                    .background(Color(red: 0.68, green: 0.89, blue: 0.82))
                                    .foregroundColor(.black)
                                    .cornerRadius(15)
                            }
                        }
                        .padding(.horizontal, 20)
                        .padding(.bottom, 10)
                    }
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                    )
                    .padding(.horizontal, 20)

                    Spacer() // Para manter a centralização da caixa
                }
                .padding(.vertical, 20) // Ajuste geral para manter a organização
            }
        }
    }
}
