//
//  GymMemberDetailView.swift
//  MaruthiGymTrainerApp
//
//  Created by Shameera on 09/11/24.
//
import SwiftUI
import SwiftData

extension GymMemberDetailView {
    @Observable
    class ViewModel:ObservableObject {
         var member:GymMember

        init(member:GymMember) {
            self.member = member
        }
        func deleteGymMember(context:ModelContext,gymMember:GymMember) {
            
            context.delete(gymMember)
            try? context.save()
        }
        
    }
    
}

struct GymMemberDetailView:View {
   
    @Environment(\.modelContext) var modelContext
    @ObservedObject var viewModel:ViewModel
    
    @Environment(\.dismiss) var dismiss
    @State var showDeleteAlert:Bool =  false
    @State var showEditScreen:Bool =  false
    
    
   init(gymMember:GymMember) {
       viewModel = ViewModel.init(member: gymMember)
    }
    var body: some View {
        ScrollView{
            VStack {
               
                GymMemberImageView.init(image: $viewModel.member.gymMemberImage , baseSize: .init(width: 100, height: 100))
                
                GymMemberDetailRow(title: "Name", value: $viewModel.member.name)
               
                GymMemberDetailRow(title: "Join Date", value:  $viewModel.member.joinDateString )
                
                GymMemberDetailRow(title: "Package", value:  $viewModel.member.packageType.title )
                
                GymMemberDetailRow(title: "Subscription Type", value:  $viewModel.member.feesTenureType.title )

                
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
                viewModel.deleteGymMember(context: modelContext, gymMember: member)
                dismiss()
            }
            
            
        } message: {
            Text("Do you want to delete this gym member?")
        }
        .sheet(isPresented: $showEditScreen) {
            GymMemberAddView()
        }

    }
}

struct GymMemberDetailRow:View {
    
    @State var title:String
    @State var value:String
   
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


