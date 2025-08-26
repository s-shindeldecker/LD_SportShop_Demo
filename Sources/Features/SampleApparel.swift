import Foundation

struct SampleApparel {
    static let all: [ApparelItem] = [
        ApparelItem(
            name: "Performance Running Shorts",
            brand: "SpeedFlex",
            category: "Running",
            price: 45.99,
            description: "Lightweight, moisture-wicking running shorts with built-in liner and side pockets",
            sizes: ["XS", "S", "M", "L", "XL"],
            colors: ["Black", "Navy", "Gray"],
            imageName: "figure.run"
        ),
        ApparelItem(
            name: "Compression Leggings",
            brand: "FlexFit",
            category: "Training",
            price: 89.99,
            description: "High-performance compression leggings for intense workouts with pocket",
            sizes: ["XS", "S", "M", "L", "XL"],
            colors: ["Black", "Navy", "Charcoal"],
            imageName: "figure.strengthtraining.traditional"
        ),
        ApparelItem(
            name: "Moisture-Wick T-Shirt",
            brand: "DryTech",
            category: "Training",
            price: 34.99,
            description: "Breathable performance t-shirt with anti-odor technology",
            sizes: ["XS", "S", "M", "L", "XL", "XXL"],
            colors: ["White", "Black", "Blue", "Red"],
            imageName: "tshirt"
        ),
        ApparelItem(
            name: "Running Jacket",
            brand: "WeatherRun",
            category: "Running",
            price: 129.99,
            description: "Water-resistant running jacket with reflective details",
            sizes: ["S", "M", "L", "XL"],
            colors: ["Black", "Navy", "Yellow"],
            imageName: "figure.run.circle"
        ),
        ApparelItem(
            name: "Yoga Pants",
            brand: "ZenFit",
            category: "Training",
            price: 69.99,
            description: "Comfortable yoga pants with wide waistband and stretch fabric",
            sizes: ["XS", "S", "M", "L", "XL"],
            colors: ["Black", "Gray", "Navy", "Burgundy"],
            imageName: "figure.mind.and.body"
        ),
        ApparelItem(
            name: "Sports Bra",
            brand: "SupportPro",
            category: "Training",
            price: 54.99,
            description: "High-impact sports bra with adjustable straps and moisture-wicking fabric",
            sizes: ["32B", "32C", "34B", "34C", "36B", "36C", "38B", "38C"],
            colors: ["Black", "Navy", "Gray", "Pink"],
            imageName: "figure.mixed.cardio"
        )
    ]
}
