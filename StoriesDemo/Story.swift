//
//  Story.swift
//  StoriesDemo
//
//  Created by Islam 3bRahiem on 3/24/20.
//  Copyright © 2020 Organization. All rights reserved.
//

import Foundation

struct HomeResponseModel : Codable {
    let status : Int?
    let message : String?
    let stories : [UserStories]?
    
    enum CodingKeys: String, CodingKey {
        
        case status = "status"
        case message = "message"
        case stories = "stories"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        stories = try values.decodeIfPresent([UserStories].self, forKey: .stories)
    }
    
}


struct UserStories : Codable {
    let id : Int?
    let name : String?
    let image : String?
    let lat : String?
    let lng : String?
    let stories : [SingleStory]?
    
    public var internalIdentifier: String
    public var lastUpdated: Int
    var lastPlayedSnapIndex = 0
    var isCompletelyVisible = false
    var isCancelledAbruptly = false

    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case name = "name"
        case image = "image"
        case lat = "lat"
        case lng = "lng"
        case stories = "stories"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        lat = try values.decodeIfPresent(String.self, forKey: .lat)
        lng = try values.decodeIfPresent(String.self, forKey: .lng)
        stories = try values.decodeIfPresent([SingleStory].self, forKey: .stories)
        internalIdentifier = ""
        lastUpdated = 0
        lastPlayedSnapIndex = 0
        isCompletelyVisible = false
        isCancelledAbruptly = false
    }
    
}


extension UserStories: Equatable {
    static func == (lhs: UserStories, rhs: UserStories) -> Bool {
        return lhs.internalIdentifier == rhs.internalIdentifier
    }
}


struct SingleStory : Codable {
    let id : Int?
    let image : String?
    let type : Int?
    let time : String?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case image = "image"
        case type = "type"
        case time = "time"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        type = try values.decodeIfPresent(Int.self, forKey: .type)
        time = try values.decodeIfPresent(String.self, forKey: .time)
    }
    
}
