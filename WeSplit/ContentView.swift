//
//  ContentView.swift
//  WeSplit
//
//  Created by Temimuraz Kasaburi on 3/3/24.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    
    @FocusState private var amountFieldIsFocused: Bool
    
    let tipPercentagers = [0, 10, 15, 20, 25, 50]
    
    var totalPerPerson:Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        
        let amountPerPerson = grandTotal / peopleCount
        return amountPerPerson
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Select the Check Amount and people") {
                    TextField("Amount",
                      value: $checkAmount,
                      format:.currency(
                        code: Locale.current.currency?.identifier ?? "GEL"
                      )
                    )
                    .keyboardType(.decimalPad)
                    .focused($amountFieldIsFocused)
                    
                    Picker("Number of people", selection: $numberOfPeople){
                        ForEach(2..<100){
                            Text("\($0) people")
                        }
                    }
                }
                Section("How much do you want to Tip?") {
                    Picker("Tip percentage", selection: $tipPercentage){
                        ForEach(tipPercentagers, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }.pickerStyle(.segmented)
                }
                Section("Total Per Person") {
                    Text(totalPerPerson, format:.currency(
                        code: Locale.current.currency?.identifier ?? "GEL"
                      )
                    )
                }
            }
            .navigationTitle("WeSplit").navigationBarTitleDisplayMode(.inline)
            .toolbar {
                if amountFieldIsFocused {
                    Button("Done"){
                        amountFieldIsFocused = false
                    }
                }
            }
        }
            
    }
}

#Preview {
    ContentView()
}
