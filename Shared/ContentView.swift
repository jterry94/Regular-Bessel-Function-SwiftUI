//
//  ContentView.swift
//  Shared
//
//  Created by Jeff Terry on 1/5/21.
//

import SwiftUI

struct ContentView: View {
    
    @State var guess = ""
    @State private var totalInput: Int? = 18
    
    private var intFormatter: NumberFormatter = {
        let f = NumberFormatter()
        f.numberStyle = .decimal
        return f
    }()
    
    var body: some View {
    
       VStack {
            HStack {
                
                TextEditor(text: $guess)

                
                Button("Calculate Bessel Functions", action: calculateBesselFunc)
                    }
            .frame(minHeight: 300, maxHeight: 800)
            .frame(minWidth: 480, maxWidth: 800)
            .padding()
        
        HStack{
            
            Text(verbatim: "Order:")
            .padding()
            TextField("Total", value: $totalInput, formatter: intFormatter)
        
                .padding()
            
            }
        }
        
    }
    
    func calculateBesselFunc()  {

    let xmax = 26.0                     /* max of x  */
    let xmin = 0.1                     /* min of x >0  */
    let step = 0.1                      /* delta x  */
    let order = totalInput ?? 0                      /* order of Bessel function */
    let start = order+25                      /* used for downward algorithm */
    var x = 0.0
    var maxIndex = 0
    guess = String(format: "J%d(x)\n", order)
    guess += "Start time \(Date())\n"
    let startTime : DispatchTime = .now()
    maxIndex = Int(((xmax-xmin)/step))+1

    for index in (0...maxIndex)
    {
        x = Double(index)*step + xmin
        
        guess += String(format: "x = %f, Downward, %7.5e, Upward, %7.5e\n", x, calculateDownwardRecursion(xValue: x, order: order, start: start),   calculateUpwardRecursion(xValue: x, order: order))
        
    }
        guess += "End time \(Date())\n"
        let duration = startTime.distance(to: .now())
        guess += "Elapsed time \(duration)\n"
        

    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
