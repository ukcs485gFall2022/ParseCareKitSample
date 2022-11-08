//
//  ProfileView.swift
//  OCKSample
//
//  Created by Corey Baker on 11/24/20.
//  Copyright © 2020 Network Reconnaissance Lab. All rights reserved.
//

import SwiftUI
import CareKitUI
import CareKitStore
import CareKit
import os.log

struct ProfileView: View {
    @Environment(\.tintColor) private var tintColor
    @StateObject var viewModel = ProfileViewModel()
    @ObservedObject var loginViewModel: LoginViewModel
    @State var firstName = ""
    @State var lastName = ""
    @State var birthday = Date()
    @State var isPresentingAddTask = false
    /* @State var note = ""
    @State var sex = OCKBiologicalSex.other("unspecified")
    @State private var sexOtherField = ""
    @State private var street = ""
    @State private var city = ""
    @State private var state = ""
    @State private var zipcode = "" */
    @State var showContact = false
    @State var showingImagePicker = false

    var body: some View {
        NavigationView {
            VStack {
                VStack(alignment: .leading) {
                    if let image = viewModel.profileUIImage {
                        Image(uiImage: image)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100, height: 100, alignment: .center)
                            .clipShape(Circle())
                            .shadow(radius: 10)
                            .overlay(Circle().stroke(Color(tintColor), lineWidth: 5))
                            .onTapGesture {
                                self.showingImagePicker = true
                            }
                    } else {
                        Image(systemName: "person.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100, height: 100, alignment: .center)
                            .clipShape(Circle())
                            .shadow(radius: 10)
                            .overlay(Circle().stroke(Color(tintColor), lineWidth: 5))
                            .onTapGesture {
                                self.showingImagePicker = true
                            }
                    }
                    Form {
                        Section(header: Text("About")) {
                            TextField("First Name", text: $firstName)
                            TextField("Last Name", text: $lastName)
                            DatePicker("Birthday",
                                       selection: $birthday,
                                       displayedComponents: [DatePickerComponents.date])
                            Picker(selection: $viewModel.sex,
                                   label: Text("Sex")) {
                                Text(OCKBiologicalSex.female.rawValue).tag(OCKBiologicalSex.female)
                                Text(OCKBiologicalSex.male.rawValue).tag(OCKBiologicalSex.male)
                                TextField("Other",
                                          text: $viewModel.sexOtherField)
                                .tag(OCKBiologicalSex.other(viewModel.sexOtherField))
                            }
                        }
                        Section(header: Text("Contact")) {
                            TextField("Street", text: $viewModel.street)
                            TextField("City", text: $viewModel.city)
                            TextField("State", text: $viewModel.state)
                            TextField("Postal code", text: $viewModel.zipcode)
                        }
                    }
                }

                Button(action: {
                    Task {
                        do {
                            try await viewModel.saveProfile(firstName,
                                                            last: lastName,
                                                            birth: birthday)
                        } catch {
                            Logger.profile.error("Error saving profile: \(error.localizedDescription)")
                        }
                    }
                }, label: {
                    Text("Save Profile")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 300, height: 50)
                })
                .background(Color(.green))
                .cornerRadius(15)

                // Notice that "action" is a closure (which is essentially
                // a function as argument like we discussed in class)
                Button(action: {
                    Task {
                        await loginViewModel.logout()
                    }
                }, label: {
                    Text("Log Out")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 300, height: 50)
                })
                .background(Color(.red))
                .cornerRadius(15)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Add Task") {
                        self.isPresentingAddTask.toggle()
                    }
                    .sheet(isPresented: $isPresentingAddTask) {
                        TaskView()
                    }
                }
            }
        }.onReceive(viewModel.$patient, perform: { patient in
            if let currentFirstName = patient?.name.givenName {
                firstName = currentFirstName
            }
            if let currentLastName = patient?.name.familyName {
                lastName = currentLastName
            }
            if let currentBirthday = patient?.birthday {
                birthday = currentBirthday
            }
        })
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(viewModel: .init(storeManager: Utility.createPreviewStoreManager()),
                    loginViewModel: .init())
            .accentColor(Color(TintColorKey.defaultValue))
    }
}
