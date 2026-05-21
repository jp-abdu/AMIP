import SwiftUI

struct Question3View: View {
    @EnvironmentObject var estado: FormularioState

    let opcoesNumericas = ["Selecione", "0", "1", "2", "3", "4", "5", "6", "7+"]
    let opcoesSimNao = ["Sim", "Não"]
    
    func valorInt(_ s: String) -> Int? {
        guard s != "Selecione", s != "7+" else { return nil }
        return Int(s)
    }
    
    func maxPermitido(excluindo campos: [String]) -> Int? {
        guard let totalComodos = valorInt(estado.q3_quantidadeComodos) else { return nil }
        let somaOutros = campos.compactMap { valorInt($0) }.reduce(0, +)
        return max(0, totalComodos - somaOutros)
    }
    
    func opcoesFiltradas(max: Int?) -> [String] {
        guard let maxInt = max else { return opcoesNumericas }
        return opcoesNumericas.filter { opcao in
            if opcao == "Selecione" { return true }
            if opcao == "7+" { return maxInt >= 7 }
            if let val = Int(opcao) { return val <= maxInt }
            return false
        }
    }
    
    func resetarDormitorioSeExceder(max: Int?) {
        guard let maxInt = max else { return }
        if let val = valorInt(estado.q3_quantidadeDormitorios), val > maxInt {
            estado.q3_quantidadeDormitorios = "Selecione"
        }
    }
    
    func resetarBanheirosComSeExceder(max: Int?) {
        guard let maxInt = max else { return }
        if let val = valorInt(estado.q3_quantidadeBanheirosCom), val > maxInt {
            estado.q3_quantidadeBanheirosCom = "Selecione"
        }
    }
    
    func resetarBanheirosSemSeExceder(max: Int?) {
        guard let maxInt = max else { return }
        if let val = valorInt(estado.q3_quantidadeBanheirosSem), val > maxInt {
            estado.q3_quantidadeBanheirosSem = "Selecione"
        }
    }

    func aoMudarComodos(_ novoValor: String) {
        estado.q3_quantidadeComodos = novoValor
        guard let maxInt = valorInt(novoValor) else { return }
        if let val = valorInt(estado.q3_quantidadeDormitorios), val > maxInt {
            estado.q3_quantidadeDormitorios = "Selecione"
        }
        if let val = valorInt(estado.q3_quantidadeBanheirosCom), val > maxInt {
            estado.q3_quantidadeBanheirosCom = "Selecione"
        }
        if let val = valorInt(estado.q3_quantidadeBanheirosSem), val > maxInt {
            estado.q3_quantidadeBanheirosSem = "Selecione"
        }
    }

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
                    
                    blocoPergunta(
                        titulo: "Quantos cômodos tem esse domicílio?",
                        selecao: Binding(
                            get: { estado.q3_quantidadeComodos },
                            set: { aoMudarComodos($0) }
                        ),
                        opcoes: opcoesNumericas
                    )
                    
                    blocoPergunta(
                        titulo: "Quantos destes são dormitórios para os moradores?",
                        selecao: Binding(
                            get: { estado.q3_quantidadeDormitorios },
                            set: { novoValor in
                                estado.q3_quantidadeDormitorios = novoValor
                                let maxCom = maxPermitido(excluindo: [novoValor, estado.q3_quantidadeBanheirosSem])
                                resetarBanheirosComSeExceder(max: maxCom)
                                let maxSem = maxPermitido(excluindo: [novoValor, estado.q3_quantidadeBanheirosCom])
                                resetarBanheirosSemSeExceder(max: maxSem)
                            }
                        ),
                        opcoes: opcoesFiltradas(
                            max: maxPermitido(excluindo: [estado.q3_quantidadeBanheirosCom, estado.q3_quantidadeBanheirosSem])
                        )
                    )
                    
                    blocoPergunta(
                        titulo: "Quantos banheiros com chuveiro e vaso sanitário?",
                        selecao: Binding(
                            get: { estado.q3_quantidadeBanheirosCom },
                            set: { novoValor in
                                estado.q3_quantidadeBanheirosCom = novoValor
                                let maxDorm = maxPermitido(excluindo: [novoValor, estado.q3_quantidadeBanheirosSem])
                                resetarDormitorioSeExceder(max: maxDorm)
                                let maxSem = maxPermitido(excluindo: [novoValor, estado.q3_quantidadeDormitorios])
                                resetarBanheirosSemSeExceder(max: maxSem)
                            }
                        ),
                        opcoes: opcoesFiltradas(
                            max: maxPermitido(excluindo: [estado.q3_quantidadeDormitorios, estado.q3_quantidadeBanheirosSem])
                        )
                    )
                    
                    blocoPergunta(
                        titulo: "Quantos banheiros sem chuveiro e com vaso sanitário?",
                        selecao: Binding(
                            get: { estado.q3_quantidadeBanheirosSem },
                            set: { novoValor in
                                estado.q3_quantidadeBanheirosSem = novoValor
                                let maxDorm = maxPermitido(excluindo: [novoValor, estado.q3_quantidadeBanheirosCom])
                                resetarDormitorioSeExceder(max: maxDorm)
                                let maxCom = maxPermitido(excluindo: [novoValor, estado.q3_quantidadeDormitorios])
                                resetarBanheirosComSeExceder(max: maxCom)
                            }
                        ),
                        opcoes: opcoesFiltradas(
                            max: maxPermitido(excluindo: [estado.q3_quantidadeDormitorios, estado.q3_quantidadeBanheirosCom])
                        )
                    )
                    
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
                        onNext: {}
                    )
                }
                .padding()
            }
        }
        .navigationBarHidden(true)
    }
    
    // MARK: - Componentes reutilizáveis
    
    @ViewBuilder
    func blocoPergunta(titulo: String, selecao: Binding<String>, opcoes: [String]) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(titulo)
                .font(.headline)
                .foregroundColor(Color(red: 0.0, green: 0.3, blue: 0.3))
                .fixedSize(horizontal: false, vertical: true)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Picker("Selecione", selection: selecao) {
                ForEach(opcoes, id: \.self) { opcao in
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
