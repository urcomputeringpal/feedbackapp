import ProjectDescription

let project = Project(
    name: "FeedbackApp",
    settings: .settings(
        base: [
            "DEVELOPMENT_TEAM": "X5RYB6DN28"
        ]
    ),
    targets: [
        .target(
            name: "FeedbackApp",
            destinations: .iOS,
            product: .app,
            bundleId: "com.urcomputeringpal.FeedbackApp",
            deploymentTargets: .iOS("26.1"),
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
            bundleId: "com.urcomputeringpal.FeedbackAppTests",
            infoPlist: .default,
            buildableFolders: [
                "FeedbackApp/Tests"
            ],
            dependencies: [.target(name: "FeedbackApp")]
        ),
    ]
)
