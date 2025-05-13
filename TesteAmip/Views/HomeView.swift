import SwiftUI

struct HomeView: View {
    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()

            VStack(spacing: 20) {
                // Logo at the top
                Image("amip_logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 180, height: 180)
                    .padding(.top, 20)

                Spacer()

                // Welcome text
                VStack(spacing: 8) {
                    Text("Olá! Seja muito bem-vindo(a)!")
                        .font(.title2)
                        .bold()
                        .multilineTextAlignment(.center)

                    Text("Abaixo você pode encontrar o questionário:")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }

                // Main card
                VStack(spacing: 16) {
                    Text("Recenseamento Ilha Primeira")
                        .font(.headline)
                        .padding(.top)

                    Image("census_image")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 270)

                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
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
                    .padding(.bottom)
                }
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                )
                .padding(.horizontal, 20)

                Spacer()
            }
        }
    }
}
