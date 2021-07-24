//
//  MovieResource.swift
//  IOS_DEV
//
//  Created by Kao Li Chi on 2021/7/24.
//

import Foundation

struct ResourceResponse: Decodable {
    let ott: String
    let result: [Resource]
   
}

struct Resource: Decodable {
    let href: String
}


let OTTurl:[ResourceResponse] = [
    ResourceResponse( ott: "Netflix",
                      result: [ Resource( href: "https://hamivideo.hinet.net/product/126160.do?cs=1" ), Resource( href: "https://www.iq.com/album/19rr8lcmtc"  ) ] ),
    ResourceResponse( ott: "MyVideo", result: [ Resource( href:  "https://www.catchplay.com/tw/video/BXxz6drj-Ydue-dvFX-b7s3-YZjdvlVU9Zxa"  ) ] )
    
]

