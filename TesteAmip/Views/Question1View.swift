import SwiftUI

struct Question1View: View {
    @State private var ruaSelecionada = ""
    @State private var numero = ""
    @State private var tipoSelecionado = ""
    @State private var coletaSelecionada = ""
    @State private var aguaSelecionada = ""
    @State private var observacoes = ""

    let ruas = ["Rua A", "Rua B", "Rua C"]
    let tiposDomicilio = [
        "DOMICÍLIO PARTICULAR PERMANENTE OCUPADO",
        "DOMICÍLIO PARTICULAR IMPROVISADO OCUPADO",
        "DOMICÍLIO COLETIVO COM MORADOR"
    ]
    let opcoesColetaLixo = [
        "Recolhido por serviço público",
        "Enterrado no terreno",
        "Queimado",
        "Jogado em terreno baldio"
    ]
    let opcoesAgua = [
        "Rede geral",
        "Poço artesiano",
        "Cisterna",
        "Outra"
    ]

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                
                // IDENTIFICAÇÃO DE DOMICÍLIO
                VStack(alignment: .leading, spacing: 16) {
                    Text("IDENTIFICAÇÃO DE DOMICÍLIO:")
                        .font(.headline)
                        .foregroundColor(Color(red: 0.0, green: 0.3, blue: 0.3))

                    Picker("Rua", selection: $ruaSelecionada) {
                        ForEach(ruas, id: \.self) { rua in
                            Text(rua)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    .padding(8)
                    .background(Color.white)
                    .cornerRadius(8)

                    TextField("Número", text: $numero)
                        .keyboardType(.numberPad)
                        .padding(8)
                        .background(Color.white)
                        .cornerRadius(8)
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color(red: 218/255, green: 249/255, blue: 254/255))
                .cornerRadius(20)

                // ESPÉCIE DE DOMICÍLIO
                VStack(alignment: .leading, spacing: 16) {
                    Text("ESPÉCIE DE DOMICÍLIO OCUPADO:")
                        .font(.headline)
                        .foregroundColor(Color(red: 0.0, green: 0.3, blue: 0.3))

                    ForEach(tiposDomicilio, id: \.self) { tipo in
                        HStack(spacing: 12) {
                            ZStack {
                                Circle()
                                    .stroke(Color.black, lineWidth: 1)
                                    .frame(width: 20, height: 20)
                                if tipoSelecionado == tipo {
                                    Circle()
                                        .fill(Color.blue)
                                        .frame(width: 10, height: 10)
                                }
                            }

                            Text(tipo)
                                .foregroundColor(.black)
                                .fixedSize(horizontal: false, vertical: true)
                        }
                        .onTapGesture {
                            tipoSelecionado = tipo
                        }
                    }
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color(red: 218/255, green: 249/255, blue: 254/255))
                .cornerRadius(20)

                // COLETA DE LIXO
                VStack(alignment: .leading, spacing: 16) {
                    Text("FORMA DE COLETA DO LIXO:")
                        .font(.headline)
                        .foregroundColor(Color(red: 0.0, green: 0.3, blue: 0.3))

                    ForEach(opcoesColetaLixo, id: \.self) { opcao in
                        HStack(spacing: 12) {
                            ZStack {
                                Circle()
                                    .stroke(Color.black, lineWidth: 1)
                                    .frame(width: 20, height: 20)
                                if coletaSelecionada == opcao {
                                    Circle()
                                        .fill(Color.blue)
                                        .frame(width: 10, height: 10)
                                }
                            }

                            Text(opcao)
                                .foregroundColor(.black)
                                .fixedSize(horizontal: false, vertical: true)
                        }
                        .onTapGesture {
                            coletaSelecionada = opcao
                        }
                    }
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color(red: 218/255, green: 249/255, blue: 254/255))
                .cornerRadius(20)

                // ABASTECIMENTO DE ÁGUA
                VStack(alignment: .leading, spacing: 16) {
                    Text("ABASTECIMENTO DE ÁGUA:")
                        .font(.headline)
                        .foregroundColor(Color(red: 0.0, green: 0.3, blue: 0.3))

                    ForEach(opcoesAgua, id: \.self) { opcao in
                        HStack(spacing: 12) {
                            ZStack {
                                Circle()
                                    .stroke(Color.black, lineWidth: 1)
                                    .frame(width: 20, height: 20)
                                if aguaSelecionada == opcao {
                                    Circle()
                                        .fill(Color.blue)
                                        .frame(width: 10, height: 10)
                                }
                            }

                            Text(opcao)
                                .foregroundColor(.black)
                                .fixedSize(horizontal: false, vertical: true)
                        }
                        .onTapGesture {
                            aguaSelecionada = opcao
                        }
                    }
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color(red: 218/255, green: 249/255, blue: 254/255))
                .cornerRadius(20)

                // OBSERVAÇÕES
                VStack(alignment: .leading, spacing: 8) {
                    Text("OBSERVAÇÕES ADICIONAIS:")
                        .font(.headline)
                        .foregroundColor(Color(red: 0.0, green: 0.3, blue: 0.3))

                    TextEditor(text: $observacoes)
                        .frame(height: 100)
                        .padding(8)
                        .background(Color.white)
                        .cornerRadius(8)
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color(red: 218/255, green: 249/255, blue: 254/255))
                .cornerRadius(20)

                // BOTÃO
                NavigationLink(destination: FormularioEnviadoView()) {
                    Text("Concluir")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.top)
            }
            .padding()
        }
        .navigationTitle("Questionário")
    }
}
