import Foundation

struct SampleEquipment {
    static let all: [EquipmentItem] = [
        EquipmentItem(
            name: "Adjustable Dumbbells",
            brand: "PowerLift",
            category: "Strength",
            price: 299.99,
            description: "Space-saving adjustable dumbbells from 5-50 lbs with quick-change mechanism",
            weight: "5-50 lbs",
            dimensions: "12\" x 8\" x 8\"",
            imageName: "dumbbell"
        ),
        EquipmentItem(
            name: "Foam Roller",
            brand: "RecoveryPro",
            category: "Recovery",
            price: 24.99,
            description: "High-density foam roller for muscle recovery and flexibility",
            weight: nil,
            dimensions: "36\" x 6\"",
            imageName: "cylinder"
        ),
        EquipmentItem(
            name: "Resistance Bands Set",
            brand: "FlexBand",
            category: "Strength",
            price: 39.99,
            description: "Complete set of 5 resistance bands with handles and carrying case",
            weight: nil,
            dimensions: "Varies by resistance",
            imageName: "figure.strengthtraining.traditional"
        ),
        EquipmentItem(
            name: "Yoga Mat",
            brand: "ZenMat",
            category: "Recovery",
            price: 49.99,
            description: "Premium non-slip yoga mat with alignment lines and carrying strap",
            weight: nil,
            dimensions: "72\" x 24\" x 1/4\"",
            imageName: "figure.mind.and.body"
        ),
        EquipmentItem(
            name: "Jump Rope",
            brand: "SpeedRope",
            category: "Cardio",
            price: 19.99,
            description: "Professional jump rope with adjustable length and ball bearings",
            weight: nil,
            dimensions: "Adjustable up to 10'",
            imageName: "figure.mixed.cardio"
        ),
        EquipmentItem(
            name: "Kettlebell",
            brand: "IronBell",
            category: "Strength",
            price: 79.99,
            description: "Cast iron kettlebell with ergonomic handle design",
            weight: "35 lbs",
            dimensions: "8\" x 6\"",
            imageName: "dumbbell.fill"
        )
    ]
}
