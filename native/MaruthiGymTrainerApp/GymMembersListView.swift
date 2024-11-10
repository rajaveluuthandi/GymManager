//
//  GymMembersListView.swift
//  MaruthiGymTrainerApp
//
//  Created by Shameera on 25/10/24.
//

import SwiftUI
import SwiftData


struct GymMembersListView: View {
    
    @Query private var members: [GymMember]
    @State var isAddMemberViewPresent:Bool = false
    var body: some View {
        NavigationStack {
                List {
                    ForEach(members) { member in
                        
                        GymMemberRow(member: member)
                    }
                }
            .navigationTitle(Text("Gym Members"))
            .navigationBarTitleDisplayMode(.automatic)
            .toolbar {
                Button(action: {
                    isAddMemberViewPresent = true
                }) {
                    Image(systemName: "plus") // Use any SF Symbol name here
                        .foregroundColor(GymAppTheme.iconsButtonsColor)    // Set color for the image
                        .accessibilityIdentifier("PlusButton")
                }

            }
        }
       
        .sheet(isPresented: $isAddMemberViewPresent) {
            GymMemberAddView().accessibilityIdentifier("GymMemberAddView")
        }
        
    }
}




struct GymMemberRow:View {
  
    var member:GymMember
    
    var body: some View {
        NavigationLink(destination:GymMemberDetailView(member: member) ) {
            VStack {
                ZStack{
                    VStack {
                        HStack {
                            GymMemberImageView.init(image: member.gymMemberImage , baseSize: .init(width: 25, height: 25))
                            VStack(alignment: .leading ){
                                Text(member.name.capitalized)
                                    .fontWeight(.semibold)
                                    .foregroundStyle(GymAppTheme.primaryTextColor)
                                Text(member.packageType.rawValue)
                                    .font(Font.caption)
                                    .foregroundStyle(GymAppTheme.secondaryTextColor)
                                
                            }
                            
                        }
                        

                    }
                    
                   
                }

                
            }
        }
    }
}



//
//#Preview {
//    GymMembersListView()
//}
