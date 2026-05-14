import SwiftUI

struct Question3View: View {
    @EnvironmentObject var estado: FormularioState
    /*
    @State private var quantidadeComodos = ""
    @State private var quantidadeDormitorios = ""
    @State private var quantidadeBanheirosCom = ""
    @State private var quantidadeBanheirosSem = ""
    @State private var acessoInternet = ""
    @State private var possuiMaquinaLavar = ""
    */
     
    let opcoesNumericas = ["Selecione", "1", "2", "3", "4", "5", "6", "7+"]
    let opcoesSimNao = ["Sim", "Não"]
    
    var body: some View {
        VStack(spacing: 0) {
            HeaderView()
            
            ScrollView {
                VStack(spacing: 20) {
                    
                    Text("3. CARACTERÍSTICAS DO DOMICÍLIO:")
                        .font(.system(size: 23))
                        .bold()
                        .foregroundColor(Color(red: 0.0, green: 0.3, blue: 0.3))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 7.5)
                    
                    blocoPergunta(titulo: "Quantos cômodos tem esse domicílio?", selecao: $estado.q3_quantidadeComodos)
                    
                    blocoPergunta(titulo: "Quantos destes são dormitórios para os moradores?", selecao: $estado.q3_quantidadeDormitorios)
                    
                    blocoPergunta(titulo: "Quantos banheiros com chuveiro e vaso sanitário?", selecao: $estado.q3_quantidadeBanheirosCom)
                    
                    blocoPergunta(titulo: "Quantos banheiros sem chuveiro e com vaso sanitário?", selecao: $estado.q3_quantidadeBanheirosSem)
                    
                    blocoRadio(titulo: "Algum morador tem acesso à internet no domicílio?", selecao: $estado.q3_acessoInternet)
                    
                    blocoRadio(titulo: "A residência possui uma máquina de lavar roupa?", selecao: $estado.q3_possuiMaquinaLavar)
                    
                    FormNavigationButtonsRows(
                        backDestination: Question2View(),
                        nextDestination: Question4View(),
                        canProceed: estado.q3_quantidadeComodos != "Selecione" &&
                                    estado.q3_quantidadeDormitorios != "Selecione" &&
                                    estado.q3_quantidadeBanheirosCom != "Selecione" &&
                                    estado.q3_quantidadeBanheirosSem != "Selecione" &&
                                    !estado.q3_acessoInternet.isEmpty &&
                                    !estado.q3_possuiMaquinaLavar.isEmpty,
                        onNext: {
                            guard let id = FormularioManager.shared.formularioId else { return }
                            APIService.shared.enviarCaracteristicas(
                                id: id,
                                comodos: estado.q3_quantidadeComodos,
                                dormitorios: estado.q3_quantidadeDormitorios,
                                banheirosCom: estado.q3_quantidadeBanheirosCom,
                                banheirosSem: estado.q3_quantidadeBanheirosSem,
                                internet: estado.q3_acessoInternet,
                                maquinaLavar: estado.q3_possuiMaquinaLavar
                            )
                        }
                    )

                }
                .padding()
            }
        }
        .navigationBarHidden(true)
    }
    
    // MARK: - Componentes reutilizáveis
    
    @ViewBuilder
    func blocoPergunta(titulo: String, selecao: Binding<String>) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(titulo)
                .font(.headline)
                .foregroundColor(Color(red: 0.0, green: 0.3, blue: 0.3))
                .fixedSize(horizontal: false, vertical: true)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Picker("Selecione", selection: selecao) {
                ForEach(opcoesNumericas, id: \.self) { opcao in
                    Text(opcao)
                }
            }
            .pickerStyle(MenuPickerStyle())
            .padding(8)
            .background(Color.white)
            .cornerRadius(8)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(red: 218/255, green: 249/255, blue: 254/255))
        .cornerRadius(20)
    }
    
    @ViewBuilder
    func blocoRadio(titulo: String, selecao: Binding<String>) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(titulo)
                .font(.headline)
                .foregroundColor(Color(red: 0.0, green: 0.3, blue: 0.3))
                .fixedSize(horizontal: false, vertical: true)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            RadioGroupViews(options: opcoesSimNao, selected: selecao)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(red: 218/255, green: 249/255, blue: 254/255))
        .cornerRadius(20)
    }
}

struct Question3View_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            Question3View()
                .environmentObject(FormularioState())
        }
    }
}
