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
            VStack{
                Image("RamaStand")
                Text("Rama")
            }
            VStack{
                Image("SitaStand")
                Text("Sita")
            }
            VStack{
                Image("HanomanStand")
                Text("Hanoman")
            }
            VStack{
                Image("RahwanaStand")
                Text("Ravana")
            }
        }
    }
}
