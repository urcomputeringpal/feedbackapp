import ProjectDescription

let project = Project(
    name: "FeedbackApp",
    targets: [
        .target(
            name: "FeedbackApp",
            destinations: .iOS,
            product: .app,
            bundleId: "dev.tuist.FeedbackApp",
            infoPlist: .extendingDefault(
                with: [
                    "UILaunchScreen": [
                        "UIColorName": "",
                        "UIImageName": "",
                    ],
                ]
            ),
            buildableFolders: [
                "FeedbackApp/Sources",
                "FeedbackApp/Resources",
            ],
            dependencies: []
        ),
        .target(
            name: "FeedbackAppTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "dev.tuist.FeedbackAppTests",
            infoPlist: .default,
            buildableFolders: [
                "FeedbackApp/Tests"
            ],
            dependencies: [.target(name: "FeedbackApp")]
        ),
    ]
)
