import SwiftUI

struct Question1View: View {
    @State private var ruaSelecionada = ""
    @State private var numero = ""
    @State private var tipoSelecionado = ""
    @State private var coletaSelecionada = ""
    @State private var aguaSelecionada = ""
    @State private var observacoes = ""

    let ruas = ["Selecione sua Rua", "- R. Marina do Sol", "- R. Marina do Frade","- R. Marina dos Coqueiros","- R. Marina da Lua","- R. Marina do Bosque", "- R. Marina Porto Bali","- R. Marina das Flores","- R. Marina das Estrelas","- R. Marina Ponta Leste"]
    let especieDomicilio = [
        "DOMICÍLIO PARTICULAR PERMANENTE OCUPADO",
        "DOMICÍLIO PARTICULAR IMPROVISADO OCUPADO",
        "DOMICÍLIO COLETIVO COM MORADOR"
    ]
    let tipoDomicilio = [
        "CASA",
        "CASA DE VILA OU CONDOMÍNIO",
        "HABITAÇÃO EM CASA DE CÔMODOS OU CORTIÇO",
        "ESTRUTURA RESIDENCIAL PERMANENTE DEGRADADA OU INACABADA",
        "ASILO OU OUTRA INSTITUIÇÃO DE PERMANÊNCIA PARA IDOSOS",
        "HOTEL OU PENSÃO",
        "ALOJAMENTO",
        "OUTROS"
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

                    ForEach(especieDomicilio, id: \.self) { tipo in
                        HStack(spacing: 12) {
                            ZStack {
                                Circle()
                                    .fill(Color.white)
                                    .frame(width: 20, height: 20)
                                    .overlay(
                                        Circle()
                                            .stroke(Color.black, lineWidth: 1)
                                    )
                                
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
                        .contentShape(Rectangle()) // Torna toda a linha clicável
                        .onTapGesture {
                            tipoSelecionado = tipo
                        }
                    }
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color(red: 218/255, green: 249/255, blue: 254/255))
                .cornerRadius(20)

                // ESPÉCIE DE DOMICÍLIO
                VStack(alignment: .leading, spacing: 16) {
                    Text("TIPO DE DOMICÍLIO")
                        .font(.headline)
                        .foregroundColor(Color(red: 0.0, green: 0.3, blue: 0.3))

                    ForEach(tipoDomicilio, id: \.self) { tipo in
                        HStack(spacing: 12) {
                            ZStack {
                                Circle()
                                    .fill(Color.white)
                                    .frame(width: 20, height: 20)
                                    .overlay(
                                        Circle()
                                            .stroke(Color.black, lineWidth: 1)
                                    )
                                
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
                        .contentShape(Rectangle()) // Torna toda a linha clicável
                        .onTapGesture {
                            tipoSelecionado = tipo
                        }
                    }
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color(red: 218/255, green: 249/255, blue: 254/255))
                .cornerRadius(20)

                // ABASTECIMENTO DE ÁGUA

                // BOTÃO
                NavigationLink(destination: Question2View()) {
                    Text("Próxima")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(red: 0/255, green: 107/255, blue: 140/255))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.top)
            }
            .padding()
        }
        .navigationTitle("Pergunta 1")
    }
}
