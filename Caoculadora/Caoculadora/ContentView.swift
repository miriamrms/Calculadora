//
//  ContentView.swift
//  Caoculadora
//
//  Created by Miriam Rayane Mendes da Silva on 07/05/24.
//

import SwiftUI

struct ContentView: View {
    @State var years: Int? = nil
    @State var months: Int? = nil
    @State var result: Int?
//    @State var porteSelecionado = "Pequeno"
//    let portes = ["Pequeno", "Médio", "Grande"]
    @State var porteSelected = Porte.pequeno
    @State var failedInput = false
    let tituloPreencheCampos = "Preencha campos para cãocular!"
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20){
                    Text("Qual a idade do seu cão?")
                        .font(.h5)
                    Text("Anos")
                        .font(.body1)
                    TextField("Quantos anos completos tem seu cão?",
                              value: $years,
                              format: .number).font(.body1)
                  
                    Text("Meses")
                        .font(.body1)
                    TextField("E quantos meses além disso ele tem?",
                              value: $months,
                              format: .number).font(.body1)
                    Text("Porte")
                        .font(.body1)
                    
                    Picker("Portes", selection: $porteSelected){
                        ForEach(Porte.allCases, id: \.self){
                            porte in
                            Text(porte.rawValue)
                        }
                    }
                    .pickerStyle(.segmented)
                    .padding()
                    
                    Spacer()
                    if let result {
                        Text("Seu cachorro tem, em idade humana...")
                            .font(.body1)
                            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                        Text("\(result) anos")
                            .font(.display)
                            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                            .contentTransition(.numericText())
                    } else {
                        Image(ImageResource.clarinha)
                            .resizable()
                            .scaledToFit()
                            .frame(maxHeight: 150)
                            .frame(maxWidth: .infinity)
                            .shadow(radius: 5)
                    }
                    
                    Spacer()

                    Button("Cãocular", action: processYears)
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(.indigo)
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .bold()
                    .font(.body1)
                    
                }
                .textFieldStyle(.roundedBorder)
                .keyboardType(.numberPad)
                .padding()
                .containerRelativeFrame(.vertical)
                .animation(.easeInOut.speed(0.5), value: result)
            }
            .alert(tituloPreencheCampos, isPresented: $failedInput, actions: {
                Button("Ok", role: .cancel, action: {})
            })
            .navigationTitle("Cãoculadora")
            .scrollDismissesKeyboard(.immediately)
            .toolbarBackground(.indigo, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarColorScheme(.dark, for: .navigationBar)
            
        }
        .fontDesign(.rounded)
    }
    
}

//MARK: - Funções
extension ContentView{
    
    func processYears(){
        print("cãocular")
        guard let years, let months else {
            print("Campos não preenchidos")
            failedInput = true
            return }
//        guard let months else { return }
        guard months > 0 || years > 0 else{
            return
        }
        
        withAnimation(.easeInOut.speed(0.5)){
            result = porteSelected.calcularIdade(deAnos: years, eMeses: months)
        }
        
    }
    
}

#Preview {
    ContentView()
}
