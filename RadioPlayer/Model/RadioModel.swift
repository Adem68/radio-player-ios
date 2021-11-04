//
//  Radio.swift
//  RadioPlayer
//
//  Created by Adem Özcan on 17.10.2021.
//

import Foundation

struct RadioModel: Codable, Identifiable {
    let id = UUID()
    public var name: String
    public var imageUrl: String
    public var streamUrl: String
    
    enum CodingKeys: String, CodingKey {
        case name = "title"
        case streamUrl = "url"
        case imageUrl = "img"
    }
}
