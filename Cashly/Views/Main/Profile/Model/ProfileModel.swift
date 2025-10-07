//
//  ProfileModel.swift
//  Cashly
//
//  Created by Nadirzada Alizaman on 29.09.25.
//

import Foundation

struct ProfileModel {
    let icon: String
    let title: String
}

struct ProfileSection {
    let title: String
    let items: [ProfileModel]
}

extension ProfileSection {
    static func mockData() -> [ProfileSection] {
        return [
            ProfileSection(title: "Account Settings", items: [
                ProfileModel(icon: "person", title: "Personal Information"),
                ProfileModel(icon: "lock.shield", title: "Password & Security"),
                ProfileModel(icon: "bell", title: "Notifications Preferences")
            ]),
            ProfileSection(title: "Community Settings", items: [
                ProfileModel(icon: "person.2", title: "Friends & Social"),
                ProfileModel(icon: "list.bullet", title: "Following List")
            ]),
            ProfileSection(title: "Other", items: [
                ProfileModel(icon: "questionmark.circle", title: "FAQ"),
                ProfileModel(icon: "info.circle", title: "Help Center")
            ])
        ]
    }
}
