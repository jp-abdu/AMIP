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
        "DOMICÍLIO PARTICULAR PERMANENTEMENTE OCUPADO",
        "DOMICÍLIO PARTICULAR OCUPADO",
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
                GroupBox(label: Text("IDENTIFICAÇÃO DE DOMICÍLIO").bold()) {
                    Picker("Rua", selection: $ruaSelecionada) {
                        ForEach(ruas, id: \.self) { rua in
                            Text(rua)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())

                    TextField("Número", text: $numero)
                        .keyboardType(.numberPad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }

                GroupBox(label: Text("ESPÉCIE DE DOMICÍLIO OCUPADO").bold()) {
                    ForEach(tiposDomicilio, id: \.self) { tipo in
                        HStack {
                            Text(tipo)
                            Spacer()
                            Image(systemName: tipoSelecionado == tipo ? "checkmark.circle.fill" : "circle")
                                .foregroundColor(tipoSelecionado == tipo ? .blue : .gray)
                        }
                        .contentShape(Rectangle())
                        .onTapGesture {
                            tipoSelecionado = tipo
                        }
                    }
                }

                GroupBox(label: Text("FORMA DE COLETA DO LIXO").bold()) {
                    ForEach(opcoesColetaLixo, id: \.self) { opcao in
                        HStack {
                            Text(opcao)
                            Spacer()
                            Image(systemName: coletaSelecionada == opcao ? "checkmark.circle.fill" : "circle")
                                .foregroundColor(coletaSelecionada == opcao ? .blue : .gray)
                        }
                        .contentShape(Rectangle())
                        .onTapGesture {
                            coletaSelecionada = opcao
                        }
                    }
                }

                GroupBox(label: Text("ABASTECIMENTO DE ÁGUA").bold()) {
                    ForEach(opcoesAgua, id: \.self) { opcao in
                        HStack {
                            Text(opcao)
                            Spacer()
                            Image(systemName: aguaSelecionada == opcao ? "checkmark.circle.fill" : "circle")
                                .foregroundColor(aguaSelecionada == opcao ? .blue : .gray)
                        }
                        .contentShape(Rectangle())
                        .onTapGesture {
                            aguaSelecionada = opcao
                        }
                    }
                }

                GroupBox(label: Text("OBSERVAÇÕES ADICIONAIS").bold()) {
                    TextEditor(text: $observacoes)
                        .frame(height: 100)
                        .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray.opacity(0.5)))
                }

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
