import SwiftUI

struct Question1View: View {
    @EnvironmentObject var estado: FormularioState
    //@State private var ruaSelecionada = ""
    //@State private var numero = ""
    //@State private var complemento = ""
    //@State private var especieSelecionada = ""
    //@State private var tipoSelecionado = ""
    
    // REMOVER as 5 linhas @State e substituir os usos:
    // ruaSelecionada        → estado.q1_ruaSelecionada
    // numero               → estado.q1_numero
    // complemento          → estado.q1_complemento
    // especieSelecionada   → estado.q1_especieSelecionada
    // tipoSelecionado      → estado.q1_tipoSelecionado

    let ruas = [
        "Selecione a Rua", "R. Marina do Sol", "R. Marina do Frade",
        "R. Marina dos Coqueiros", "R. Marina da Lua", "R. Marina do Bosque",
        "R. Marina Porto Bali", "R. Marina das Flores", "R. Marina das Estrelas",
        "R. Marina Ponta Leste"
    ]

    let especieDomicilio = [
        "Domicílio particular permanente ocupado",
        "Domicílio particular improvisado ocupado",
        "Domicílio coletivo com morador"
    ]

    let tipoDomicilio = [
        "Casa", "Casa de vila ou condomínio",
        "Habitação em casa de comodos ou cortiço",
        "Estrutura residencial permanente degradada ou inacabada",
        "Asilo ou outra instituição de permanência para idosos",
        "Hotel ou pensão", "Alojamento", "Outros"
    ]

    var body: some View {
        VStack(spacing: 0) {
            HeaderView()

            ScrollView {
                VStack(spacing: 20) {
                    Text("1. IDENTIFICAÇÃO DE DOMICÍLIO")
                        .font(.system(size: 23))
                        .bold()
                        .foregroundColor(Color(red: 0.0, green: 0.3, blue: 0.3))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 7.5)

                    // Bloco: Endereço
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Endereço:")
                            .font(.headline)
                            .foregroundColor(Color(red: 0.0, green: 0.3, blue: 0.3))

                        Picker("Selecione a rua", selection: $estado.q1_ruaSelecionada) {
                            ForEach(ruas, id: \.self) { rua in
                                Text(rua)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                        .padding(8)
                        .background(Color.white)
                        .cornerRadius(8)

                        LabeledTextFieldViews(title: "Número", text: $estado.q1_numero, keyboardType: .numberPad)
                        LabeledTextFieldViews(title: "Complemento", text: $estado.q1_complemento)
                    }
                    .padding()
                    .background(Color(red: 218/255, green: 249/255, blue: 254/255))
                    .cornerRadius(20)

                    // Bloco: Espécie de domicílio
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Espécie de domicílio:")
                            .font(.headline)
                            .foregroundColor(Color(red: 0.0, green: 0.3, blue: 0.3))

                        RadioGroupViews(options: especieDomicilio, selected: $estado.q1_especieSelecionada)
                    }
                    .padding()
                    .background(Color(red: 218/255, green: 249/255, blue: 254/255))
                    .cornerRadius(20)

                    // Bloco: Tipo de domicílio
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Tipo de domicílio:")
                            .font(.headline)
                            .foregroundColor(Color(red: 0.0, green: 0.3, blue: 0.3))

                        RadioGroupViews(options: tipoDomicilio, selected: $estado.q1_tipoSelecionado)
                    }
                    .padding()
                    .background(Color(red: 218/255, green: 249/255, blue: 254/255))
                    .cornerRadius(20)

                    // Botões de navegação
                    FormNavigationButtonsRows(
                        backDestination: HomeView(),
                        nextDestination: Question2View(),
                        canProceed: estado.q1_ruaSelecionada != "" &&
                            estado.q1_ruaSelecionada != "Selecione a Rua" &&
                            !estado.q1_numero.isEmpty &&
                            !estado.q1_especieSelecionada.isEmpty &&
                            !estado.q1_tipoSelecionado.isEmpty,
                        onNext: {
                            guard let id = FormularioManager.shared.formularioId else { return }
                            APIService.shared.enviarDomicilio(
                                id: id,
                                rua: estado.q1_ruaSelecionada,
                                numero: estado.q1_numero,
                                complemento: estado.q1_complemento,
                                especie: estado.q1_especieSelecionada,
                                tipo: estado.q1_tipoSelecionado
                            )
                        }
                    )
                }
                .padding()
            }
        }
        .navigationBarHidden(true)
        
    }
}

struct Question1View_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            Question1View()
                .environmentObject(FormularioState())
        }
    }
}
