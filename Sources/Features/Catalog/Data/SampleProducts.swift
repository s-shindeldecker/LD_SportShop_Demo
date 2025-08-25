import Foundation

enum SampleProducts {
    static let all: [Product] = [
        .init(id: UUID(uuidString: "2DD37466-C1BF-4BE1-B0E1-EA5D91FE31D9") ?? UUID(), name: "Stride Pro 5", brand: "FleetPeak", price: 129.99, imageName: "shoe", rating: 4.6, isNew: true, badgeText: "New"),
        .init(id: UUID(uuidString: "3EE48577-D2C6-5CF2-C1F2-FB6E02AF42A0") ?? UUID(), name: "RoadRacer X", brand: "SwiftCo", price: 159.99, imageName: "shoe", rating: 4.8, badgeText: "Deal"),
        .init(id: UUID(uuidString: "4FF59688-E3D4-6DA3-D2A3-AC7F13AA53B1") ?? UUID(), name: "TrailGrip 3", brand: "TerraRun", price: 109.99, imageName: "shoe", rating: 4.2),
        .init(id: UUID(uuidString: "5AA60799-F4E1-7EA4-E3A4-BD8A24BA64C2") ?? UUID(), name: "CushionMax", brand: "CloudStep", price: 99.99, imageName: "shoe", rating: 4.1),
        .init(id: UUID(uuidString: "6BB71800-A5F5-8FA5-F4A5-CE9B35CB75D3") ?? UUID(), name: "Velocity Elite", brand: "RapidOne", price: 189.99, imageName: "shoe", rating: 4.9),
        .init(id: UUID(uuidString: "7CC82911-B6A6-9AA6-A5A6-DF0C46DC86E4") ?? UUID(), name: "Urban Dash", brand: "MetroAth", price: 89.99, imageName: "shoe", rating: 3.9),
        .init(id: UUID(uuidString: "8DD93022-C7B7-0BB7-B6B7-E01D57ED97F5") ?? UUID(), name: "Marathoner", brand: "Endurix", price: 149.99, imageName: "shoe", rating: 4.4),
        .init(id: UUID(uuidString: "9EE04133-D8C8-1CC8-C7C8-F12E68FE08A6") ?? UUID(), name: "TempoLight", brand: "FeatherRun", price: 119.99, imageName: "shoe", rating: 4.3),
        .init(id: UUID(uuidString: "0FF15244-E9D9-2DD9-D8D9-023F79AF19B7") ?? UUID(), name: "Stabilize Pro", brand: "FormFit", price: 139.99, imageName: "shoe", rating: 4.5),
        .init(id: UUID(uuidString: "1AAA6355-F0E0-3EE0-E9E0-1340800020C8") ?? UUID(), name: "GripX Trail", brand: "TerraRun", price: 129.99, imageName: "shoe", rating: 4.0)
    ]
}
