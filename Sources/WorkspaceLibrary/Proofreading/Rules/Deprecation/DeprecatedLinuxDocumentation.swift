/*
 DeprecatedLinuxDocumentation.swift

 This source file is part of the Workspace open source project.
 https://github.com/SDGGiesbrecht/Workspace#workspace

 Copyright ©2017–2018 Jeremy David Giesbrecht and the Workspace project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGCornerstone
import SDGCommandLine

struct DeprecatedLinuxDocumentation : Rule {

    static let name = UserFacingText<InterfaceLocalization, Void>({ (localization, _) in
        switch localization {
        case .englishCanada:
            return "Deprecated Linux Documentation"
        }
    })

    static let message = UserFacingText<InterfaceLocalization, Void>({ (localization, _) in
        switch localization {
        case .englishCanada:
            return "Special compilation conditions are no longer necessary for Linux documentation."
        }
    })

    static func check(file: TextFile, in project: PackageRepository, status: ProofreadingStatus, output: inout Command.Output) {
        for match in file.contents.scalars.matches(for: "\u{4C}inuxDocs".scalars) {
            reportViolation(in: file, at: match.range, message: message, status: status, output: &output)
        }
    }
}