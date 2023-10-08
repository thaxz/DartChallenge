//
//  MacthesRow.swift
//  DartChallenge
//
//  Created by thaxz on 08/10/23.
//

import SwiftUI

struct MacthesRow: View {
    // ADD Task as a property to populate it
    var body: some View {
        ZStack(alignment: .leading){
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(.theme.rowBg)
            VStack(alignment: .leading, spacing: 8){
                Text("Match nº".uppercased())
                    .font(.custom("Futura-Bold", size: 22))
                    .foregroundColor(.white)
                Text("DATE: ".uppercased())
                    .font(.custom("Futura-Medium", size: 16))
                    .foregroundColor(.white)
                Text("POINTS: ".uppercased())
                    .font(.custom("Futura-Medium", size: 16))
                    .foregroundColor(.white)
            }
            .padding(.horizontal, 16)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 120)
    }
}

struct MacthesRow_Previews: PreviewProvider {
    static var previews: some View {
        MacthesRow()
    }
}
