// swift-tools-version:4.1

/*
 Package.swift

 This source file is part of the Workspace open source project.
 https://github.com/SDGGiesbrecht/Workspace#workspace

 Copyright ©2017–2018 Jeremy David Giesbrecht and the Workspace project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import PackageDescription

/// Workspace automates management of Swift projects.
///
/// > [Πᾶν ὅ τι ἐὰν ποιῆτε, ἐκ ψυχῆς ἐργάζεσθε, ὡς τῷ Κυρίῳ καὶ οὐκ ἀνθρώποις.](https://www.biblegateway.com/passage/?search=Colossians+3&version=SBLGNT;NIV)
/// >
/// > [Whatever you do, work from the heart, as working for the Lord and not for men.](https://www.biblegateway.com/passage/?search=Colossians+3&version=SBLGNT;NIV)
/// >
/// > ―⁧שאול⁩/Shaʼul
///
/// ### Features
///
/// - Provides rigorous validation:
///     - [Test coverage](https://sdggiesbrecht.github.io/Workspace/🇨🇦EN/Types/TestingConfiguration/Properties/enforceCoverage.html)
///     - [Compiler warnings](https://sdggiesbrecht.github.io/Workspace/🇨🇦EN/Types/TestingConfiguration/Properties/prohibitCompilerWarnings.html)
///     - [Documentation coverage](https://sdggiesbrecht.github.io/Workspace/🇨🇦EN/Types/APIDocumentationConfiguration/Properties/enforceCoverage.html)
///     - [Example validation](https://sdggiesbrecht.github.io/Workspace/🇨🇦EN/Types/Examples.html)
///     - [Style proofreading](https://sdggiesbrecht.github.io/Workspace/🇨🇦EN/Types/ProofreadingConfiguration.html) (including [SwiftLint](https://github.com/realm/SwiftLint))
///     - [Reminders](https://sdggiesbrecht.github.io/Workspace/🇨🇦EN/Types/ProofreadingRule/Cases/manualWarnings.html)
///     - [Continuous integration set‐up](https://sdggiesbrecht.github.io/Workspace/🇨🇦EN/Types/ContinuousIntegrationConfiguration/Properties/manage.html) ([Travis CI](https://travis-ci.org) with help from [Swift Version Manager](https://github.com/kylef/swiftenv))
/// - Generates API [documentation](https://sdggiesbrecht.github.io/Workspace/🇨🇦EN/Types/APIDocumentationConfiguration/Properties/generate.html).
/// - Automates code maintenance:
///     - [Embedded resources](https://sdggiesbrecht.github.io/Workspace/🇨🇦EN/Types/PackageResources.html)
///     - [Inherited documentation](https://sdggiesbrecht.github.io/Workspace/🇨🇦EN/Types/DocumentationInheritance.html)
///     - [Xcode project generation](https://sdggiesbrecht.github.io/Workspace/🇨🇦EN/Types/XcodeConfiguration/Properties/manage.html)
/// - Automates open source details:
///     - [File headers](https://sdggiesbrecht.github.io/Workspace/🇨🇦EN/Types/FileHeaderConfiguration.html)
///     - [Read‐me files](https://sdggiesbrecht.github.io/Workspace/🇨🇦EN/Types/ReadMeConfiguration.html)
///     - [Licence notices](https://sdggiesbrecht.github.io/Workspace/🇨🇦EN/Types/LicenceConfiguration.html)
///     - [Contributing instructions](https://sdggiesbrecht.github.io/Workspace/🇨🇦EN/Types/GitHubConfiguration.html)
/// - Designed to interoperate with the [Swift Package Manager](https://swift.org/package-manager/).
/// - Manages projects for macOS, Linux, iOS, watchOS and tvOS.
/// - [Configurable](https://sdggiesbrecht.github.io/Workspace/🇨🇦EN/Libraries/WorkspaceConfiguration.html)
///
/// ### The Workspace Workflow
///
/// (The following sample package is a real repository. You can use it to follow along.)
///
/// #### When the Repository Is Cloned
///
/// The need to hunt down workflow tools can deter contributors. On the other hand, including them in the repository causes a lot of clutter. To reduce both, when a project using Workspace is pulled, pushed, or cloned...
///
/// ```shell
/// git clone https://github.com/SDGGiesbrecht/SamplePackage
/// ```
///
/// ...only one small piece of Workspace comes with it: A short script called “Refresh” that comes in two variants, one for each operating system.
///
/// *Hmm... I wish I had more tools at my disposal... Hey! What if I...*
///
/// #### Refresh the Project
///
/// To refresh the project, double‐click the `Refresh` script for the corresponding operating system. (If you are on Linux and double‐clicking fails or opens a text file, see [here](https://sdggiesbrecht.github.io/Workspace/🇨🇦EN/Types/Linux.html).)
///
/// `Refresh` opens a terminal window, and in it Workspace reports its actions while it sets the project folder up for development. (This may take a while the first time, but subsequent runs are faster.)
///
/// *This looks better. Let’s get coding!*
///
/// *[Add this... Remove that... Change something over here...]*
///
/// *...All done. I wonder if I broke anything while I was working? Hey! It looks like I can...*
///
/// #### Validate Changes
///
/// When the project seems ready for a push, merge, or pull request, validate the current state of the project by double‐clicking the `Validate` script.
///
/// `Validate` opens a terminal window and in it Workspace runs the project through a series of checks.
///
/// When it finishes, it prints a summary of which tests passed and which tests failed.
///
/// *Oops! I never realized that would happen...*
///
/// #### Summary
///
/// 1. `Refresh` before working.
/// 2. `Validate` when it looks complete.
///
/// *Wow! That was so much easier than doing it all manually!*
///
/// ### Applying Workspace to a Project
///
/// To apply Workspace to a project, run the following command in the root of the project’s repository. (This requires a full install.)
///
/// ```shell
/// $ workspace refresh
/// ```
///
/// By default, Workspace refrains from tasks which would involve modifying project files. Such tasks must be activated with a [configuration](https://sdggiesbrecht.github.io/Workspace/🇨🇦EN/Libraries/WorkspaceConfiguration.html) file.
let package = Package(
    name: "Workspace",
    products: [
        // #documentation(WorkspaceConfiguration)
        /// The root API used in configuration files.
        ///
        /// Workspace can be configured by placing a Swift file named `Workspace.swift` in the project root.
        ///
        /// The contents of a configuration file might look something like this:
        ///
        /// ```swift
        /// import WorkspaceConfiguration
        ///
        /// /*
        ///  Exernal packages can be imported with this syntax:
        ///  import [module] // [url], [version], [product]
        ///  */
        /// import SDGControlFlow // https://github.com/SDGGiesbrecht/SDGCornerstone, 0.10.0, SDGControlFlow
        ///
        /// let configuration = WorkspaceConfiguration()
        /// configuration.optIntoAllTasks()
        /// configuration.documentation.readMe.manage = true
        /// configuration.documentation.readMe.shortProjectDescription["en"] = "This is just an example."
        /// ```
        .library(name: "WorkspaceConfiguration", targets: ["WorkspaceConfiguration"]),

        /// Workspace.
        .executable(name: "workspace", targets: ["WorkspaceTool"]),
        /// Arbeitsbereich.
        .executable(name: "arbeitsbereich", targets: ["WorkspaceTool"])
    ],
    dependencies: [
        .package(url: "https://github.com/SDGGiesbrecht/SDGCornerstone", .exact(Version(0, 10, 1))),
        .package(url: "https://github.com/SDGGiesbrecht/SDGCommandLine", .exact(Version(0, 3, 3))),
        .package(url: "https://github.com/SDGGiesbrecht/SDGSwift", .exact(Version(0, 2, 2))),
        .package(url: "https://github.com/apple/swift\u{2D}package\u{2D}manager", .exact(Version(0, 2, 0)))
    ],
    targets: [
        // The executable. (Multiple products duplicate this with localized names.)
        .target(name: "WorkspaceTool", dependencies: [.targetItem(name: "WorkspaceLibrary")]),
        // The umbrella library. (Shared by the various localized executables.)
        .target(name: "WorkspaceLibrary", dependencies: [
            "WSGeneralImports",
            "WorkspaceProjectConfiguration",
            "WSInterface"
            ]),

        // Components

        // Defines the public command line interface.
        .target(name: "WSInterface", dependencies: [
            "WSGeneralImports",
            "WorkspaceProjectConfiguration",
            "WSProject",
            "WSValidation",
            "WSScripts",
            "WSGit",
            "WSOpenSource",
            "WSLicence",
            "WSGitHub",
            "WSContinuousIntegration",
            "WSResources",
            "WSFileHeaders",
            "WSExamples",
            "WSNormalization",
            "WSXcode",
            "WSProofreading",
            "WSTesting",
            "WSDocumentation"
            ]),

        // Workspace scripts.
        .target(name: "WSScripts", dependencies: [
            "WSGeneralImports",
            "WSProject"
            ]),

        // Git management.
        .target(name: "WSGit", dependencies: [
            "WSGeneralImports",
            "WSProject"
            ]),

        // Open source management.
        .target(name: "WSOpenSource", dependencies: [
            "WSGeneralImports",
            "WSProject",
            "WSExamples"
            ]),

        // Licence management.
        .target(name: "WSLicence", dependencies: [
            "WSGeneralImports",
            "WorkspaceConfiguration",
            "WSProject"
            ]),

        // GitHub management.
        .target(name: "WSGitHub", dependencies: [
            "WSGeneralImports",
            "WSProject",
            "WorkspaceProjectConfiguration"
            ]),

        // Continuous integration management.
        .target(name: "WSContinuousIntegration", dependencies: [
            "WSGeneralImports",
            "WSProject",
            "WSDocumentation"
            ]),

        // Resource management.
        .target(name: "WSResources", dependencies: [
            "WSGeneralImports",
            "WSProject",
            "WSSwift",
            .productItem(name: "SDGSwiftPackageManager", package: "SDGSwift"),
            .productItem(name: "SwiftPM", package: "swift\u{2D}package\u{2D}manager")
            ]),

        // File header management.
        .target(name: "WSFileHeaders", dependencies: [
            "WSGeneralImports",
            "WSProject"
            ]),

        // Example management.
        .target(name: "WSExamples", dependencies: [
            "WSGeneralImports",
            "WSProject"
            ]),

        // Normalization.
        .target(name: "WSNormalization", dependencies: [
            "WSGeneralImports",
            "WSProject"
            ]),

        // Xcode project management.
        .target(name: "WSXcode", dependencies: [
            "WSGeneralImports",
            "WSProject",
            "WorkspaceProjectConfiguration",
            .productItem(name: "SDGXcode", package: "SDGSwift")
            ]),

        // Proofreading.
        .target(name: "WSProofreading", dependencies: [
            "WSGeneralImports",
            "WSProject",
            "WSThirdParty",
            .productItem(name: "SDGExternalProcess", package: "SDGCornerstone")
            ]),

        // Testing.
        .target(name: "WSTesting", dependencies: [
            "WSGeneralImports",
            "WSProject",
            "WSValidation",
            "WSContinuousIntegration",
            "WSProofreading",
            .productItem(name: "SDGExternalProcess", package: "SDGCornerstone"),
            .productItem(name: "SDGXcode", package: "SDGSwift")
            ]),

        // Documentation generation.
        .target(name: "WSDocumentation", dependencies: [
            "WSGeneralImports",
            "WSProject",
            "WSValidation",
            "WSThirdParty",
            "WSXcode",
            "WSSwift",
            .productItem(name: "SDGExternalProcess", package: "SDGCornerstone"),
            .productItem(name: "SDGXcode", package: "SDGSwift"),
            .productItem(name: "_SDGSwiftSource", package: "SDGSwift")
            ]),

        // Mechanism for embedding third party tools.
        .target(name: "WSThirdParty", dependencies: [
            "WSGeneralImports",
            "WorkspaceConfiguration",
            .productItem(name: "SDGExternalProcess", package: "SDGCornerstone")
            ]),

        // Utilities for validation reports.
        .target(name: "WSValidation", dependencies: [
            "WSGeneralImports",
            "WSProject"
            ]),

        // Utilities related to Swift syntax.
        .target(name: "WSSwift", dependencies: [
            "WSGeneralImports"
            ]),

        // Defines general project structure queries and cache.
        .target(name: "WSProject", dependencies: [
            "WSGeneralImports",
            "WorkspaceConfiguration",
            "WorkspaceProjectConfiguration",
            .productItem(name: "SDGExternalProcess", package: "SDGCornerstone"),
            .productItem(name: "SDGSwiftPackageManager", package: "SDGSwift"),
            .productItem(name: "SDGSwiftConfigurationLoading", package: "SDGSwift"),
            .productItem(name: "SwiftPM", package: "swift\u{2D}package\u{2D}manager")
            ]),

        // #documentation(WorkspaceConfiguration)
        /// The root API used in configuration files.
        ///
        /// Workspace can be configured by placing a Swift file named `Workspace.swift` in the project root.
        ///
        /// The contents of a configuration file might look something like this:
        ///
        /// ```swift
        /// import WorkspaceConfiguration
        ///
        /// /*
        ///  Exernal packages can be imported with this syntax:
        ///  import [module] // [url], [version], [product]
        ///  */
        /// import SDGControlFlow // https://github.com/SDGGiesbrecht/SDGCornerstone, 0.10.0, SDGControlFlow
        ///
        /// let configuration = WorkspaceConfiguration()
        /// configuration.optIntoAllTasks()
        /// configuration.documentation.readMe.manage = true
        /// configuration.documentation.readMe.shortProjectDescription["en"] = "This is just an example."
        /// ```
        .target(name: "WorkspaceConfiguration", dependencies: [
            "WSLocalizations",
            .productItem(name: "SDGControlFlow", package: "SDGCornerstone"),
            .productItem(name: "SDGLogic", package: "SDGCornerstone"),
            .productItem(name: "SDGCollections", package: "SDGCornerstone"),
            .productItem(name: "SDGText", package: "SDGCornerstone"),
            .productItem(name: "SDGLocalization", package: "SDGCornerstone"),
            .productItem(name: "SDGCalendar", package: "SDGCornerstone"),
            .productItem(name: "SDGSwift", package: "SDGSwift"),
            .productItem(name: "SDGSwiftConfiguration", package: "SDGSwift")
            ]),

        // Defines the lists of supported localizations.
        .target(name: "WSLocalizations", dependencies: [
            .productItem(name: "SDGLocalization", package: "SDGCornerstone")
            ]),

        // Centralizes imports needed almost everywhere.
        .target(name: "WSGeneralImports", dependencies: [
            "WSLocalizations",

            .productItem(name: "SDGControlFlow", package: "SDGCornerstone"),
            .productItem(name: "SDGLogic", package: "SDGCornerstone"),
            .productItem(name: "SDGMathematics", package: "SDGCornerstone"),
            .productItem(name: "SDGCollections", package: "SDGCornerstone"),
            .productItem(name: "SDGText", package: "SDGCornerstone"),
            .productItem(name: "SDGPersistence", package: "SDGCornerstone"),
            .productItem(name: "SDGLocalization", package: "SDGCornerstone"),
            .productItem(name: "SDGExternalProcess", package: "SDGCornerstone"),

            .productItem(name: "SDGCommandLine", package: "SDGCommandLine"),

            .productItem(name: "SDGSwift", package: "SDGSwift")
            ]),

        // Tests

        .target(name: "WSGeneralTestImports", dependencies: [
            "WSGeneralImports",
            "WorkspaceConfiguration",
            "WSInterface",
            .productItem(name: "SDGPersistenceTestUtilities", package: "SDGCornerstone"),
            .productItem(name: "SDGLocalizationTestUtilities", package: "SDGCornerstone"),
            .productItem(name: "SDGXCTestUtilities", package: "SDGCornerstone"),
            .productItem(name: "SDGCommandLineTestUtilities", package: "SDGCommandLine")
            ]),
        .testTarget(name: "WorkspaceLibraryTests", dependencies: [
            "WSGeneralTestImports",
            .productItem(name: "SDGExternalProcess", package: "SDGCornerstone")
            ]),
        .target(name: "test‐ios‐simulator", dependencies: [
            "WSGeneralImports",
            "WSInterface",
            .productItem(name: "SDGExternalProcess", package: "SDGCornerstone")
            ], path: "Tests/test‐ios‐simulator"),
        .target(name: "test‐tvos‐simulator", dependencies: [
            "WSGeneralImports",
            "WSInterface",
            .productItem(name: "SDGExternalProcess", package: "SDGCornerstone")
            ], path: "Tests/test‐tvos‐simulator"),
        .target(name: "WSConfigurationExample", dependencies: [
            "WorkspaceConfiguration",
            .productItem(name: "SDGControlFlow", package: "SDGCornerstone")
        ], path: "Tests/WSConfigurationExample"),

        // Other

        // This allows Workspace to load and use a configuration from its own development state, instead of an externally available stable version.
        .target(name: "WorkspaceProjectConfiguration", dependencies: [
            "WorkspaceConfiguration"
        ], path: "", sources: ["Workspace.swift"])
    ]
)
