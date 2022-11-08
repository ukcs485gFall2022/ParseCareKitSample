//
//  Profile.swift
//  OCKSample
//
//  Created by Corey Baker on 11/25/20.
//  Copyright © 2020 Network Reconnaissance Lab. All rights reserved.
//

import Foundation
import CareKit
import CareKitStore
import SwiftUI
import ParseCareKit
import os.log
import Combine
import ParseSwift

class ProfileViewModel: ObservableObject {
    // MARK: Public read, private write properties
    @Published private(set) var patient: OCKPatient?
    @Published private(set) var contact: OCKContact?
    @Published var firstName = ""
    @Published var lastName = ""
    @Published var sex: OCKBiologicalSex = .other("unspecified")
    @Published var sexOtherField = ""
    @Published var note = ""
    @Published var street = ""
    @Published var city = ""
    @Published var state = ""
    @Published var zipcode = ""
    @Published var isShowingSaveAlert = false
    @Published public internal(set) var error: Error?
    @Published var profileUIImage = UIImage(systemName: "person.fill") {
        willSet {
            guard self.profileUIImage != newValue,
                let inputImage = newValue else {
                return
            }

            if !settingProfilePictureForFirstTime {
                guard var user = User.current?.mergeable,
                      let image = inputImage.jpegData(compressionQuality: 0.25) else {
                    return
                }

                let newProfilePicture = ParseFile(name: "profile.jpg", data: image)
                user.profilePicture = newProfilePicture
                let userToSave = user
                Task {
                    do {
                        _ = try await userToSave.save()
                        Logger.profile.info("Saved updated profile picture successfully.")
                    } catch {
                        Logger.profile.error("Couldn't save profile picture: \(error.localizedDescription)")
                    }
                }
            }
        }
    }
    private(set) var storeManager: OCKSynchronizedStoreManager
    private var settingProfilePictureForFirstTime = true

    // MARK: Private read/write properties
    private var cancellables: Set<AnyCancellable> = []

    init(storeManager: OCKSynchronizedStoreManager? = nil) {
        self.storeManager = storeManager ?? StoreManagerKey.defaultValue
        reloadViewModel()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(reloadViewModel(_:)),
                                               name: Notification.Name(rawValue: Constants.shouldRefreshView),
                                               object: nil)
    }

    // MARK: Helpers (private)
    private func clearSubscriptions() {
        cancellables = []
    }

    @objc private func reloadViewModel(_ notification: Notification? = nil) {
        Task {
            _ = await findAndObserveCurrentProfile()
        }
    }

    @MainActor
    private func findAndObserveCurrentProfile() async {
        guard let uuid = try? Utility.getRemoteClockUUID() else {
            Logger.profile.error("Could not get remote uuid for this user.")
            return
        }
        clearSubscriptions()

        // Build query to search for OCKPatient
        // swiftlint:disable:next line_length
        var queryForCurrentPatient = OCKPatientQuery(for: Date()) // This makes the query for the current version of Patient
        queryForCurrentPatient.ids = [uuid.uuidString] // Search for the current logged in user

        do {
            guard let appDelegate = AppDelegateKey.defaultValue,
                  let foundPatient = try await appDelegate.store?.fetchPatients(query: queryForCurrentPatient),
                let currentPatient = foundPatient.first else {
                // swiftlint:disable:next line_length
                Logger.profile.error("Could not find patient with id \"\(uuid)\". It's possible they have never been saved.")
                return
            }
            self.observePatient(currentPatient)

            // Query the contact also so the user can edit
            var queryForCurrentContact = OCKContactQuery(for: Date())
            queryForCurrentContact.ids = [uuid.uuidString]
            guard let foundContact = try await appDelegate.store?.fetchContacts(query: queryForCurrentContact),
                let currentContact = foundContact.first else {
                // swiftlint:disable:next line_length
                Logger.profile.error("Error: Couldn't find contact with id \"\(uuid)\". It's possible they have never been saved.")
                return
            }
            self.observeContact(currentContact)

            try? await fetchProfilePicture()
        } catch {
            // swiftlint:disable:next line_length
            Logger.profile.error("Could not find patient with id \"\(uuid)\". It's possible they have never been saved. Query error: \(error.localizedDescription)")
        }
    }

    @MainActor
    private func observePatient(_ patient: OCKPatient) {
        storeManager.publisher(forPatient: patient,
                               categories: [.add, .update, .delete])
            .sink { [weak self] in
                self?.patient = $0 as? OCKPatient
            }
            .store(in: &cancellables)
    }

    @MainActor
    private func findAndObserveCurrentContact() async {
        guard let uuid = try? Utility.getRemoteClockUUID() else {
            Logger.profile.error("Could not get remote uuid for this user.")
            return
        }
        clearSubscriptions()

        // Build query to search for OCKPatient
        // swiftlint:disable:next line_length
        var queryForCurrentPatient = OCKPatientQuery(for: Date()) // This makes the query for the current version of Patient
        queryForCurrentPatient.ids = [uuid.uuidString] // Search for the current logged in user

        do {
            guard let appDelegate = AppDelegateKey.defaultValue,
                  let foundPatient = try await appDelegate.store?.fetchPatients(query: queryForCurrentPatient),
                let currentPatient = foundPatient.first else {
                // swiftlint:disable:next line_length
                Logger.profile.error("Could not find patient with id \"\(uuid)\". It's possible they have never been saved.")
                return
            }
            self.observePatient(currentPatient)

            // Query the contact also so the user can edit
            var queryForCurrentContact = OCKContactQuery(for: Date())
            queryForCurrentContact.ids = [uuid.uuidString]
            guard let foundContact = try await appDelegate.store?.fetchContacts(query: queryForCurrentContact),
                let currentContact = foundContact.first else {
                // swiftlint:disable:next line_length
                Logger.profile.error("Error: Couldn't find contact with id \"\(uuid)\". It's possible they have never been saved.")
                return
            }
            self.observeContact(currentContact)

            try? await fetchProfilePicture()
        } catch {
            // swiftlint:disable:next line_length
            Logger.profile.error("Could not find patient with id \"\(uuid)\". It's possible they have never been saved. Query error: \(error.localizedDescription)")
        }
    }

    @MainActor
    private func observeContact(_ contact: OCKContact) {

        storeManager.publisher(forContact: contact,
                               categories: [.add, .update, .delete])
            .sink { [weak self] in
                self?.contact = $0 as? OCKContact
            }
            .store(in: &cancellables)
    }

    @MainActor
    private func fetchProfilePicture() async throws {

         // Profile pics are stored in Parse User.
        guard let currentUser = try await User.current?.fetch() else {
            Logger.profile.error("User isn't logged in")
            return
        }

        if let pictureFile = currentUser.profilePicture {

            // Download picture from server
            do {
                let profilePicture = try await pictureFile.fetch()
                guard let path = profilePicture.localURL?.relativePath else {
                    return
                }
                self.profileUIImage = UIImage(contentsOfFile: path)
            } catch {
                Logger.profile.error("Couldn't fetch profile picture: \(error.localizedDescription).")
            }
        }
        self.settingProfilePictureForFirstTime = false
    }

    // MARK: User intentional behavior
    @MainActor
    func saveProfile() async throws {
        isShowingSaveAlert = true // Make alert pop up for user.

        if var patientToUpdate = patient {
            // If there is a currentPatient that was fetched, check to see if any of the fields changed
            var patientHasBeenUpdated = false

            if patient?.name.givenName != firstName {
                patientHasBeenUpdated = true
                patientToUpdate.name.givenName = firstName
            }

            if patient?.name.familyName != lastName {
                patientHasBeenUpdated = true
                patientToUpdate.name.familyName = lastName
            }

            if patient?.birthday != birth {
                patientHasBeenUpdated = true
                patientToUpdate.birthday = birth
            }

            if patient?.sex != sex {
                patientHasBeenUpdated = true
                patientToUpdate.sex = sex
            }

            let notes = [OCKNote(author: first, title: "my note", content: note)]
            if patient?.notes != notes {
                patientHasBeenUpdated = true
                patientToUpdate.notes = notes
            }

            if patientHasBeenUpdated {
                let updated = try await storeManager.store.updateAnyPatient(patientToUpdate)
                Logger.profile.info("Successfully updated patient")
                guard let updatedPatient = updated as? OCKPatient else {
                    return
                }
                self.patient = updatedPatient
            }

        } else {
            guard let remoteUUID = try? Utility.getRemoteClockUUID().uuidString else {
                Logger.profile.error("The user currently is not logged in")
                return
            }

            var newPatient = OCKPatient(id: remoteUUID, givenName: first, familyName: last)
            newPatient.birthday = birth

            // This is new patient that has never been saved before
            let addedPatient = try await storeManager.store.addAnyPatient(newPatient)
            Logger.profile.info("Succesffully saved new patient")
            guard let addedOCKPatient = addedPatient as? OCKPatient else {
                Logger.profile.error("Could not cast to OCKPatient")
                return
            }
            self.patient = addedOCKPatient
        }
    }

    @MainActor
    func saveContact() async throws {
        isShowingSaveAlert = true // Make alert pop up for user.

        if var patientToUpdate = patient {
            // If there is a currentPatient that was fetched, check to see if any of the fields changed
            var patientHasBeenUpdated = false

            if patient?.name.givenName != first {
                patientHasBeenUpdated = true
                patientToUpdate.name.givenName = first
            }

            if patient?.name.familyName != last {
                patientHasBeenUpdated = true
                patientToUpdate.name.familyName = last
            }

            if patient?.birthday != birth {
                patientHasBeenUpdated = true
                patientToUpdate.birthday = birth
            }

            if patient?.sex != sex {
                patientHasBeenUpdated = true
                patientToUpdate.sex = sex
            }

            let notes = [OCKNote(author: first, title: "my note", content: note)]
            if patient?.notes != notes {
                patientHasBeenUpdated = true
                patientToUpdate.notes = notes
            }

            if patientHasBeenUpdated {
                let updated = try await storeManager.store.updateAnyPatient(patientToUpdate)
                Logger.profile.info("Successfully updated patient")
                guard let updatedPatient = updated as? OCKPatient else {
                    return
                }
                self.patient = updatedPatient
            }

        } else {
            guard let remoteUUID = try? Utility.getRemoteClockUUID().uuidString else {
                Logger.profile.error("The user currently is not logged in")
                return
            }

            var newPatient = OCKPatient(id: remoteUUID, givenName: first, familyName: last)
            newPatient.birthday = birth

            // This is new patient that has never been saved before
            let addedPatient = try await storeManager.store.addAnyPatient(newPatient)
            Logger.profile.info("Succesffully saved new patient")
            guard let addedOCKPatient = addedPatient as? OCKPatient else {
                Logger.profile.error("Could not cast to OCKPatient")
                return
            }
            self.patient = addedOCKPatient
        }
    }
}
