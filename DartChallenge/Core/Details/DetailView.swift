//
//  DetailView.swift
//  DartChallenge
//
//  Created by thaxz on 08/10/23.
//

import SwiftUI

struct DetailView: View {
    
    @EnvironmentObject private var routerManager: NavigationRouter
    
    var body: some View {
        ZStack(alignment: .leading){
            Color.theme.background.ignoresSafeArea()
            VStack(alignment: .leading, spacing: 32){
                Text("match nº X".uppercased())
                    .font(.custom("Futura-Bold", size: 30))
                    .foregroundColor(.white)
                    .padding(.top, 70)
                HStack {
                    pointsSection
                    Spacer()
                    timeSection
                }
                dartsSection
                Spacer()
                PrimaryButton(title: "previous macthes") {
                    routerManager.popToLast()
                }
                SecondaryButton(title: "main menu") {
                    routerManager.popToRoot()
                }
            }
            .padding(.horizontal, 20)
        }
    }
}

// MARK: Components

extension DetailView {
    
    var pointsSection: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(Color.theme.rowBg)
            VStack{
                Image("medalImage")
                Text("x".uppercased())
                    .font(.custom("Futura-Bold", size: 16))
                    .foregroundColor(.white)
                Text("points".uppercased())
                    .font(.custom("Futura-Medium", size: 20))
                    .foregroundColor(.white)
            }
        }
        .frame(width: 160, height: 160)
    }
    
    var timeSection: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(Color.theme.rowBg)
            VStack{
                Image("clockImage")
                Text("XX".uppercased())
                    .font(.custom("Futura-Bold", size: 16))
                    .foregroundColor(.white)
                Text("minutes".uppercased())
                    .font(.custom("Futura-Medium", size: 20))
                    .foregroundColor(.white)
            }
        }
        .frame(width: 160, height: 160)
    }
    
    var dartsSection: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(.theme.rowBg)
            .frame(width: 350, height: 180)
            VStack{
                // todo: put in a list
                DartRow(status: "MISS", number: 2)
            }
        }
    }
    
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView()
            .environmentObject(NavigationRouter())
    }
}
