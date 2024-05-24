//
//  StatisticView.swift
//  crashcourse
//
//  Created by Egemen Öngel on 21.05.2024.
//

import SwiftUI

struct StatisticView: View {

    let stat: StatisticModel


    var body: some View {
        VStack(alignment: .leading, spacing: 4){
            Text(stat.title)
                .font(.caption)
                .foregroundStyle(Color.theme.secondaryText)
            Text(stat.value.doubleWith2Decimal().description)
                .font(.headline)
                .foregroundStyle(Color.theme.accent)

            HStack{
                Image(systemName: "triangle.fill")
                    .font(.caption2)
                    .rotationEffect(Angle(degrees: (stat.percentageChange ?? 0) >=  0 ? 0 : 180))

                Text((stat.percentageChange != nil ? stat.percentageChange?.doubleWith2Decimal().description : "")!)
                    .font(.caption)
                    .bold()
            }
            .foregroundStyle((stat.percentageChange ?? 0) >=  0 ? Color.theme.green : Color.theme.red)
            .opacity(stat.percentageChange == nil ? 0.0 : 1.0)
        }
    }
}


struct StatisticView_Previews: PreviewProvider {
    static var previews: some View {
        StatisticView(stat: dev.stat1)
            .previewLayout(.sizeThatFits)
        StatisticView(stat: dev.stat2)
            .previewLayout(.sizeThatFits)
        StatisticView(stat: dev.stat3)
            .previewLayout(.sizeThatFits)
    }
}
