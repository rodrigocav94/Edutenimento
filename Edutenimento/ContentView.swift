//
//  ContentView.swift
//  Edutenimento
//
//  Created by Rodrigo Cavalcanti on 05/12/20.
//

import SwiftUI
struct ContentView: View {
    @State private var jogo = false
    @State private var numeroDaTabela = 1
    @State private var numeroAtual = 10
    @State private var numeroMáximo = 10
    @State private var perguntaAtual = 1
    @State private var campoDeResposta = ""
    @State private var respondeu = false
    @State private var pontuaçãoPositiva = 0
    @State private var pontuaçãoNegativa = 0
    @State private var encerrar = false
    @State private var numeroDaTabelaArray = [String]()
    @State private var numeroAtualArray = [String]()
    @State private var numerosUsados = [Int]()
    
    func transformarEmArray(variável: Int, coleção: inout [String]) {
        coleção = []
        for letra in String(variável) {
            coleção.append(String(letra))
        }
    }
    
    func verificar(ultima: Bool) {
        respondeu = true
        if Int(campoDeResposta) ?? 0 == self.numeroDaTabela * self.numeroAtual {
            pontuaçãoPositiva += 1
        } else {
            pontuaçãoNegativa += 1
        }
        if !ultima {
            var numeroTemporario = Int.random(in: 1...numeroMáximo)
            var pesquisando = false
            
            while !pesquisando {
                for _ in numerosUsados {
                    if !numerosUsados.contains(numeroTemporario) {
                        pesquisando = true } else {
                            numeroTemporario = Int.random(in: 1...numeroMáximo)
                        }
                }
            }
            numeroAtual = numeroTemporario
            numerosUsados.append(numeroAtual)
            campoDeResposta = ""
            perguntaAtual += 1
        } else {
            encerrar = true
        }
    }
    
    struct botãoIrEVir: View {
        var texto: String
        var body: some View {
            Image(systemName: texto)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 35)
                .foregroundColor(.white)
        }
    }
    struct botãoUI: View {
        var texto: String
        var body: some View {
            Image(systemName: texto)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 15)
                .foregroundColor(.white)
                .padding()
        }
    }
    struct quadradoMultiplicador: View {
        var numero: Int
        var selecionado: Bool
        var body: some View {
            Text("\(numero)")
                .font(.largeTitle)
                .fontWeight(.black)
                .frame(width: 80, height: 60, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .background(selecionado ? Color.black : Color.white)
                .foregroundColor(selecionado ? .white : .black)
        }
    }
    
    struct iconeBarraDeNavegação: View {
        var simbolo: String
        var cor: Color
        var texto: String
        var body: some View {
            Image(systemName: simbolo)
                .font(Font.system(size: 20, weight: .black))
                .foregroundColor(cor)
            
            Text(texto)
                .font(.title)
                .fontWeight(.black)
                .foregroundColor(cor)
        }
    }
    struct imagemNumero: View {
        var tamanho: CGFloat
        var arrayDeStrings = [String]()
        var body: some View {
            HStack {
                ForEach(arrayDeStrings, id:\.self) {
                    Image(decorative: "f\($0)")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                            .frame(width: tamanho)
                }
            }
        }
    }
    func seleçãoQuadrado(numero: Int) -> some View {
        if numeroMáximo == numero {
            return quadradoMultiplicador(numero: numero, selecionado: true)
        } else {
            return quadradoMultiplicador(numero: numero, selecionado: false)
        }
    }

    var body: some View {
        Group {
            
            //TELA INICIAL
            if !jogo {
                ZStack {
                    Color.orange
                        .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                    VStack {
                        Spacer()
                        HStack {
                            Button(action: { if numeroDaTabela > 1 { numeroDaTabela -= 1}
                                transformarEmArray(variável: numeroDaTabela, coleção: &numeroDaTabelaArray)
                            }, label: {
                                botãoIrEVir(texto: "minus")
                            })
                            imagemNumero(tamanho: numeroDaTabela > 9 ? 150 : 210, arrayDeStrings: numeroDaTabelaArray)

                            Button(action: { if numeroDaTabela < 12 { numeroDaTabela += 1}
                                transformarEmArray(variável: numeroDaTabela, coleção: &numeroDaTabelaArray)
                            }, label: {
                                botãoIrEVir(texto: "plus")
                            })
                        }
                        Spacer()
                        VStack(spacing: 12) {
                            Text("MULTIPLICADOR")
                                .font(.title2)
                                .fontWeight(.heavy)
                                .foregroundColor(Color.white)
                            VStack(spacing: 0) {
                                HStack(spacing: 0) {
                                    Button(action: {numeroMáximo = 5}, label: {
                                        seleçãoQuadrado(numero: 5)
                                    })
                                    Button(action: {numeroMáximo = 10}, label: {
                                        seleçãoQuadrado(numero: 10)
                                    })
                                }
                                HStack(spacing: 0) {
                                    Button(action: {numeroMáximo = 20}, label: {
                                        seleçãoQuadrado(numero: 20)
                                    })
                                    Button(action: {numeroMáximo = 50}, label: {
                                        seleçãoQuadrado(numero: 50)
                                    })
                                }
                            }
                            .clipShape(RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/))
                        }
                        Spacer()
                        Button(action: {
                            jogo = true
                            numeroAtual = Int.random(in: 1...numeroMáximo)
                            numerosUsados.append(numeroAtual)
                            transformarEmArray(variável: numeroDaTabela, coleção: &numeroDaTabelaArray)
                            transformarEmArray(variável: numeroAtual, coleção: &numeroAtualArray)
                        }, label: {
                            botãoIrEVir(texto: "chevron.right.circle.fill")
                        })
                        Spacer()
                    }
                }
                
                //FIM
            }
            
            //TELA DO JOGO
            else {
                ZStack {
                    Color.orange
                        .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                    VStack {
                        //BARRA DE MENU
                        HStack {
                            Button(action: {
                                jogo = false
                                numeroAtual = Int.random(in: 1...numeroMáximo)
                                perguntaAtual = 1
                                campoDeResposta = ""
                                respondeu = false
                                pontuaçãoPositiva = 0
                                pontuaçãoNegativa = 0
                                encerrar = false
                                numerosUsados = []
                            }, label: {
                                botãoUI(texto: "chevron.left")
                            })
                            Spacer()
                            if campoDeResposta != "" && perguntaAtual != numeroMáximo {
                                Button(action: { verificar(ultima: false)
                                    transformarEmArray(variável: numeroAtual, coleção: &numeroAtualArray)
                                }, label: {
                                    botãoUI(texto: "chevron.right")
                                })
                            } else if campoDeResposta != "" && perguntaAtual == numeroMáximo && !encerrar {
                                Button(action: { verificar(ultima: true)}, label: {
                                    botãoUI(texto: "chevron.right")
                                })
                            }
                        }
                        //FIM DA BARRA DE PONTUAÇÃO
                        HStack {
                            Spacer()
                            Spacer()
                            iconeBarraDeNavegação(simbolo: "checkmark", cor: .green, texto: "\(pontuaçãoPositiva)")
                            Spacer()
                            iconeBarraDeNavegação(simbolo: "xmark", cor: .red, texto: "\(pontuaçãoNegativa)")
                            Spacer()
                            iconeBarraDeNavegação(simbolo: "questionmark", cor: .blue, texto: "\(perguntaAtual)/\(numeroMáximo)")
                            Spacer()
                            Spacer()
                        }
                        // O JOGO
                        Spacer()
                        HStack {
                            imagemNumero(tamanho: 70, arrayDeStrings: numeroDaTabelaArray)
                            
                            Text("X")
                                .font(.system(size: 80, weight: .black, design: .default))
                                .fontWeight(.black)
                                .foregroundColor(.white)
                            
                            imagemNumero(tamanho: 70, arrayDeStrings: numeroAtualArray)
                        }
                        Spacer()
                        TextField("?", text: $campoDeResposta)
                            .keyboardType(.numberPad)
                            .font(.system(size: 120, weight: .black, design: .default))
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                        Spacer()
                    }
                } //FIM DO ZSTACK DO JOGO
            }
        }
        .animation(.default)
        .onAppear(perform: {
            transformarEmArray(variável: numeroDaTabela, coleção: &numeroDaTabelaArray)
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
