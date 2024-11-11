//
//  GymMemberAddView.swift
//  MaruthiGymTrainerApp
//
//  Created by Shameera on 08/11/24.
//


import SwiftUI
import SwiftData
import PhotosUI
import Combine


struct GymMemberAddView:View {

    @Environment(\.modelContext) private var modelContext
    
    @ObservedObject var viewModel:GymMemberAddViewConfig
    
    @Environment(\.dismiss) var dismiss
    
    @State var isPhotoPickerPresent = false
   
    init(config:GymMemberAddViewConfig)
    {
        self.viewModel = config
    }
        var body: some View {
            NavigationStack {
                Form {
                    Section{
                        GymMemberAddImageView()
                            .environmentObject(viewModel)
                            .onTapGesture {
                                isPhotoPickerPresent = true
                            }
                    }
                    .listRowBackground(Color.clear)
                    Section {
                        
                        
                        
                        // Name Text Field
                        TextField("Name", text: $viewModel.name)
                            .accessibilityIdentifier("gym_memberAdd_name_textfield")
                        if !viewModel.isValidNameInputs {
                          
                            Text("""
                                 * Name should not empty
                                 * Name should not contain special characters and numbers
                                 * Should not exceed \(viewModel.nameNumberOfCharacters)
                                """)
                                .font(.footnote)
                                .foregroundStyle(Color.red)
                                .accessibilityIdentifier("gym_memberAdd_name_error")
                        
                           
                        }
                        // Joining Date Picker
                        DatePicker("Joining Date", selection: $viewModel.joiningDate,in: ...Date(), displayedComponents: .date)
                            .accessibilityIdentifier("gym_memberAdd_joiningDate")
                        
                        
                        Picker("Gym Package", selection: $viewModel.selectedPackage) {
                            ForEach(GymPackage.allCases,id: \.self) { package in
                                Text(package.title)
                                    .accessibilityIdentifier(package.title)
                                    .foregroundStyle(GymAppTheme.primaryTextColor)
                            }
                        }.accessibilityIdentifier("gym_memberAdd_package_picker")
                        
                        Picker("Fees Tenure", selection: $viewModel.selectedFeesTenure) {
                            ForEach(FeesTenure.allCases,id: \.self) { tenure in
                                Text(tenure.title)
                                    .accessibilityIdentifier(tenure.title)
                                    .foregroundStyle(GymAppTheme.primaryTextColor)
                            }
                        }.accessibilityIdentifier("gym_memberAdd_feesTenure_picker")
                        
                       
                    }
                    header: {
                        Text("Basic")
                    }.accessibilityIdentifier("gymMemberAddView_basicFields_section")
                    
                    Section {
                        Text(viewModel.estimatedPriceString)
                            .accessibilityIdentifier("gymMemberAddView_estimated_fees_string")
                    } header: {
                        Text("Fees")
                    } footer: {
                        
                        if viewModel.selectedFeesTenure != .monthly {
                            Text("\(viewModel.selectedFeesTenure.discount)% discount Applied")
                                .accessibilityIdentifier("gymMemberAddView_discountApplied_string")
                        }
                        
                    }.accessibilityIdentifier("gymMemberAddView_feesFields_section")
                    
                }
                .navigationTitle(
                    Text("Gym Member Details")
                )
                .toolbar {
                    ToolbarItem(placement: ToolbarItemPlacement.cancellationAction) {
                        Button(action: {
                            withAnimation {
                                viewModel.addGymMember(context: modelContext)
                            }
                            dismiss()

                        }) {
//                                Image(systemName: "xmark") // Use any SF Symbol name here
//                                        // Set color for the image

                            Text("Cancel")
                                .foregroundColor(.red)

                        }
                        .accessibilityIdentifier("gymMemberAddView_toolbar_cancelButton")
                    }
                    
                    ToolbarItem(placement: .confirmationAction) {
                        Button(action: {
                            withAnimation {
                                viewModel.addGymMember(context: modelContext)
                            }
                            dismiss()

                        }) {

                            Text("Done")
                                .foregroundStyle( viewModel.isDoneButtonEnabled ?  GymAppTheme.iconsButtonsColor : Color.gray)

                        }
                        
                        .disabled(!viewModel.isDoneButtonEnabled)
                        .accessibilityIdentifier("gymMemberAddView_toolbar_DoneButton")
                    }
                
                    
                }
                .photosPicker(isPresented: $isPhotoPickerPresent, selection: $viewModel.selectedPhotoItem, matching: .images, photoLibrary: .shared())
                
                
            }
        }
    
}

extension GymMemberAddView {
    
    struct GymMemberAddImageView:View {
        
        @EnvironmentObject var viewModel:GymMemberAddViewConfig
        
        var body: some View {
            
            HStack {
                VStack {
                    GymMemberImageView.init(image: viewModel.selectedImage, baseSize: .init(width: 50, height: 50))

                    Text("Change Photo")
                        .fontWeight(.medium)
                        .foregroundStyle(GymAppTheme.universalThemeColor)
                }
                .background {
                    Color.clear
                }
                
            }
            .frame( maxWidth: .infinity, alignment: .center)
            .background(Color.clear)
            
        }
    }
}



/// After iOS 17 @observable property macro  is enough

class GymMemberAddViewConfig: ObservableObject {
    
//        @Published var editGymMember:GymMember?
    
    @Published var name: String = ""
    @Published var joiningDate: Date = Date()
    @Published var selectedPackage: GymPackage = .standard
    @Published var selectedFeesTenure:FeesTenure = .monthly
  
     var nameNumberOfCharacters:Int = 30
    @Published var selectedImage:UIImage?
    @Published var selectedPhotoItem: PhotosPickerItem? // PhotosPicker selection
    
    @Published private var editMember:GymMember?
    
    
    private var cancellables = Set<AnyCancellable>()

    var estimatedPriceString:String {
        
        return GymPricingHandler.init(package: selectedPackage, feesTenure: selectedFeesTenure).calculatedFeesString
        
    }
    
    
    init(gymMember:GymMember?) {
        
        self.editMember = gymMember
        mandatorySink()
       
    }

    
    init() {
        mandatorySink()
        
    }
    
    func mandatorySink() {
        // Listen selectedPhotoItem value and update selectedImage value using combine
        
        $selectedPhotoItem
            .receive(on: DispatchQueue.main)
            .sink { [weak self] newValue in
            
            Task {
                if let data = try? await newValue?.loadTransferable(type: Data.self),
                   let image = UIImage(data: data) {
                    DispatchQueue.main.async { [weak self ] in
                        self?.selectedImage = image
                    }
                   
                }
            }
        }
        .store(in: &cancellables)

        $editMember
                .sink { [weak self] member in
                    guard let editGymMember  = member else {
                        return
                    }
                    self?.name = editGymMember.name
                    self?.joiningDate = editGymMember.joiningDate
                    self?.selectedPackage = editGymMember.packageType
                    self?.selectedFeesTenure = editGymMember.feesTenureType
                    self?.selectedImage = editGymMember.gymMemberImage
                }
                .store(in: &cancellables)
    }
    
    func addGymMember(context:ModelContext) {
        let trimmedName = name.trimmingCharacters(in: .whitespacesAndNewlines)

        if let editMemberObject =  editMember {
            editMemberObject.name = trimmedName
            editMemberObject.joiningDate = joiningDate
            editMemberObject.packageType = selectedPackage
            editMemberObject.feesTenureType = selectedFeesTenure
            editMemberObject.imageData = selectedImage?.pngData()
            context.insert(editMemberObject)
            try? context.save()
            
        } else {
            if  let gymMember = try? GymMember(id: UUID(), name: trimmedName, joiningDate: joiningDate, packageType: selectedPackage, feesTenureType: selectedFeesTenure) {
                gymMember.imageData = selectedImage?.pngData()
                context.insert(gymMember)
                try? context.save()
            }
        }
        
       
        
    }
    
    
    var isValidNameInputs:Bool {
        
      
        
        var isNameRegexValid: Bool {
            let nameRegex = "^[A-Za-z\\s]+$" // Regex for alphabetic characters and spaces
            let namePredicate = NSPredicate(format: "SELF MATCHES %@", nameRegex)
            return  namePredicate.evaluate(with: name)
        }
        
        var isNameExceededLimit:Bool {
            
            return (name.count > nameNumberOfCharacters)
        }
        // Unlike Done button error message should not shown for empty name.
        // Error message should show only for character limit exceeded and regex format unmaching like numbers and special characters should not allowed
        return  (!isNameExceededLimit && isNameRegexValid) || name.isEmpty
        
    }
    
    var isDoneButtonEnabled:Bool {
        // Done button should not enable when empty and incorrect name format.
        // So checking name and invalid regex format. if anyone false restricting done button
        // Trimmed version of name to avoid whitespace issues at the beginning and end
           let trimmedName = name.trimmingCharacters(in: .whitespacesAndNewlines)
        
        return !trimmedName.isEmpty && isValidNameInputs
        
    }
    
    

}
