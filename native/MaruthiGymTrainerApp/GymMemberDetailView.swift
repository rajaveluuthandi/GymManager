//
//  GymMemberDetailView.swift
//  MaruthiGymTrainerApp
//
//  Created by Shameera on 09/11/24.
//
import SwiftUI
import SwiftData

struct GymMemberDetailView:View {
   
    @Environment(\.modelContext) var modelContext
//    @ObservedObject var viewModel:GymMemberAddViewConfig
    
    @Environment(\.dismiss) var dismiss
   
    @State var showDeleteAlert:Bool =  false
    @State var showEditScreen:Bool =  false
    
     var  gymMember:GymMember
    
    
    init( gymMember: GymMember) {
        self.gymMember = gymMember
    }
    var body: some View {
        ScrollView{
            VStack {
               
                GymMemberImageView.init(image: gymMember.gymMemberImage , baseSize: .init(width: 100, height: 100))
                
                GymMemberDetailRow(title: "Name", value: gymMember.name)
               
                GymMemberDetailRow(title: "Join Date", value:  gymMember.joinDateString )
                
                GymMemberDetailRow(title: "Package", value:  gymMember.packageType.title )
                
                GymMemberDetailRow(title: "Subscription Type", value:  gymMember.feesTenureType.title )

                
            }
        }
        .background(Color.init(hex: "#F2F2F7"))
        .toolbar {
            Button("Delete", systemImage: "trash") {
                showDeleteAlert = true
                
            }
            Button("Edit", systemImage: "pencil") {
                showEditScreen = true
                
            }
        }.alert("Important", isPresented: $showDeleteAlert) {
            
            Button("No",role: .cancel) {
                showDeleteAlert = false
            }
            
            Button("Yes", role: .destructive) {
//                viewModel.deleteGymMember(context: modelContext, gymMember: viewModel.member)
                dismiss()
            }
            
            
        } message: {
            Text("Do you want to delete this gym member?")
        }
        .sheet(isPresented: $showEditScreen) {
            GymMemberAddView(config: GymMemberAddViewConfig(gymMember: gymMember))
        }

    }
}

struct GymMemberDetailRow:View {
    
     var title:String
     var value:String
   
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text(title)
                    .font(Font.caption)
                    .foregroundStyle(GymAppTheme.secondaryTextColor)
                Text(value)
                    .fontWeight(.semibold)
                    .foregroundStyle(GymAppTheme.primaryTextColor)
            }.padding(.leading,10)
        }
        .padding(10)
        .frame( maxWidth: .infinity, alignment: .leading)
        .background(Color.white)
    }
}


