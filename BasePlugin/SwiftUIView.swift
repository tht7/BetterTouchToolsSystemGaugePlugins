//
//  SwiftUIView.swift
//  BTTStreamDeckPluginCPUUsage
//
//  Created by tht7 on 10/10/2022.
//  Copyright © 2022 Andreas Hegenberg. All rights reserved.
//

import SwiftUI

struct SwiftUIView: View {
    let gaugeName: String
    let rawPrecent: CGFloat
    let formattedNumber: String
    let gradient = Gradient(colors: [.green, .yellow, .orange, .red])
    
    var body: some View {
            //.foregroundColor(Color(nsColor: colors.intermediate(percentage: speed)))
        Gauge(value: rawPrecent, in: 0...100) {
          Text(gaugeName)
        } currentValueLabel: {
            Text(formattedNumber)
                //.foregroundColor(Color(nsColor: colors.intermediate(percentage: speed)))
        }
        .gaugeStyle(.accessoryCircular)
        //.gaugeStyle(CircularGaugeStyle(tint: gradient))
        .tint(gradient)
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView(gaugeName: "TST", rawPrecent: 3.0, formattedNumber: "Poo")
    }
}
