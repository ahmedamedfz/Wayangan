//
//  File.swift
//  
//
//  Created by Ahmad Fariz on 15/04/23.
//

import Foundation
import SwiftUI

struct CollectionView: View{
    var body : some View {
        ScrollView(.horizontal){
            HStack{
                VStack{
                    Image("RamaStand").resizable().scaledToFit().padding(100)
                    Text("Rama").padding(10)
                }
            
                VStack{
                    Image("SitaStand").resizable().scaledToFit().padding(100)
                    Text("Sita").padding(10)
                }
            
                VStack{
                    Image("HanomanStand").resizable().scaledToFit().padding(100)
                    Text("Hanoman").padding(10)
                }
            
                VStack{
                    Image("RahwanaStand").resizable().scaledToFit().padding(100)
                    Text("Ravana").padding(10)
                }
            }.padding(50)
        }
    }
}
