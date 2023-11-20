//
//  ContentView.swift
//  We Split
//
//  Created by Dylan Silva on 11/18/23.
//

// tells swift to import SwiftUI framework
import SwiftUI

struct ContentView: View {
    // establish defaults
    // values which get interacted with by user
    // views are a function of their state
    @State private var checkAmount: Double = 0.0
    @State private var numPeople = 2
    @State private var tipPercent = 20
    // hide keyboard
    // focus state
    @FocusState private var amountIsFocused: Bool
    
    let tipPercentages = [0, 10, 15, 20, 25]
    
    var totalPerPerson: Double {
        // calc total per person
        let peopleCount = Double(numPeople + 2)
        let tipSelection = Double(tipPercent)
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        return amountPerPerson
    }
    
    var body: some View {
        NavigationStack {
            Form {
                // treat text: as a value
                // Locale based on location
                // read currency code if they have one
                // else use USD
                Section {
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                    // number keyboard and decimal
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    Picker("Number of People", selection: $numPeople) {
                        // When we gave the numPeople default value of 2, range starts count 0 at 2, 2, 3, 4
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
                    // take user to another scene to pick new view
                    // navigation stack is able to move between scenes easy
                    // can choose any style
                    .pickerStyle(.navigationLink)
                }
                
                Section("Pick Tip Amount") {
                    //Text("Pick Tip Amount")
                    
                    Picker("Tip Percentange", selection: $tipPercent) {
                        ForEach(tipPercentages, id: \.self) {
                            // notice the format percent
                            Text($0, format: .percent)
                        }
                    }
                    // jump between percentages
                    .pickerStyle(.segmented)
                }
                Section("Total") {
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
            }
            // make sure thnis is on the form
            .navigationTitle("We Split")
            // appear next to keyboard or a t the top
            .toolbar {
                if amountIsFocused {
                // check if amount is focused is true or not
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}



// just for xcode to preview the view on the canvas window
// can change device view at the top
// editor canvas
// opt+cmd+c refresh preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
