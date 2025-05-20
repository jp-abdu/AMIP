import SwiftUI

struct Question1View: View {
    @State private var ruaSelecionada = ""
    @State private var numero = ""
    @State private var complemento = ""
    @State private var tipoSelecionado = ""
    @State private var coletaSelecionada = ""
    @State private var aguaSelecionada = ""
    @State private var observacoes = ""

    let ruas = ["Selecione a Rua", "R. Marina do Sol", "R. Marina do Frade","R. Marina dos Coqueiros","R. Marina da Lua","R. Marina do Bosque", "R. Marina Porto Bali","R. Marina das Flores","R. Marina das Estrelas","R. Marina Ponta Leste"]
    let especieDomicilio = [
        "Domicílio particular permanente ocupado",
        "Domicílio particular improvisado ocupado",
        "Domicílio coletivo com morador"
    ]
    let tipoDomicilio = [
        "Casa",
        "Casa de vila ou condomínio",
        "Habitação em casa de comodos ou cortiço",
        "Estrutura residencial permanente degradada ou inacabada",
        "Asilo ou outra instituição de permanência para idosos",
        "Hotel ou pensão",
        "Alojamento",
        "Outros"
    ]

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                
                    Text("1. IDENTIFICAÇÃO DE DOMICÍLIO:")
                        .font(.system(size: 23))
                        .bold()
                        .foregroundColor(Color(red: 0.0, green: 0.3, blue: 0.3))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 7.5)
                            

                
                // IDENTIFICAÇÃO DE DOMICÍLIO
                VStack(alignment: .leading, spacing: 16) {
                    Text("IDENTIFICAÇÃO DE DOMICÍLIO:")
                        .font(.headline)
                        .foregroundColor(Color(red: 0.0, green: 0.3, blue: 0.3))

                    Picker("Selecione a rua", selection: $ruaSelecionada) {
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
                    
                    TextField("Complemento", text: $complemento)
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
                                    .frame(width: 25, height: 25)
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
                                .font(.system(size: 17))
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
                                    .frame(width: 25, height: 25)
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
                                .font(.system(size: 17))

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
    
    }
}
struct Question1View_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            Question1View()
        }
    }
}
