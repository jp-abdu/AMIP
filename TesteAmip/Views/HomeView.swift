import SwiftUI

struct HomeView: View {
    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()

                VStack(spacing: 12) {
                    // Logo fixa no topo da tela
                    VStack {
                        Image("amip_logo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 180, height: 180)
                            .padding(.top, 10)
                            .offset(y:-90)
                    }
                    .frame(maxWidth: .infinity, alignment: .top) // Garantindo que a logo fique no topo

                    Spacer()

                    // Textos de boas-vindas
                    Text("Olá! Seja muito bem-vindo(a)!")
                        .font(.title2)
                        .bold()
                        .multilineTextAlignment(.center)
                        .offset(y:-110)

                    Text("Abaixo você pode encontrar o questionário:")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .offset(y:-115)
                        .padding(.bottom, 20)

                    // Caixa centralizada com borda
                    VStack {
                        Text("Recenseamento Ilha Primeira")
                            .font(.headline)
                            .padding(.top, 10)
                            .offset(y:-70)

                        Image("census_image")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200, height: 270)
                            .padding(.vertical, 10)
                            .offset(y:-70)
                        HStack {
                            VStack(alignment: .leading) {
                                Text("Recenseamento")
                                    .font(.subheadline)
                                    .offset(y:-70)
                                Text("Menos de 15 minutos")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                    .offset(y:-70)
                            }

                            Spacer()

                            NavigationLink(destination: Question1View()) {
                                Text("Iniciar")
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 8)
                                    .background(Color(red: 0.68, green: 0.89, blue: 0.82))
                                    .foregroundColor(.black)
                                    .cornerRadius(15)
                                    .offset(y:-70)
                            }
                        }
                        .padding(.horizontal, 20)
                        .padding(.bottom, 10)
                        
                    }
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                            .offset(y:-70)
                    )
                    .padding(.horizontal, 20)
                    .offset(y:-50)
                    Spacer()

            VStack(spacing: 12) {
                // Logo fixa no topo da tela
                VStack {
                    Image("amip_logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 180, height: 180)
                        .padding(.top, 10)

                }
                .frame(maxWidth: .infinity, alignment: .top)

                Spacer()

                // Textos de boas-vindas
                Text("Olá! Seja muito bem-vindo(a)!")
                    .font(.title2)
                    .bold()
                    .multilineTextAlignment(.center)

                Text("Abaixo você pode encontrar o questionário:")
                    .font(.subheadline)
                    .foregroundColor(.gray)

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

                Spacer()
            }
        }
    }
    }

}
