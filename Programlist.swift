//
//  Tvinfo.swift
//  TestApp2
//
//  Created by 阿部樹 on 2021/02/20.
//

import Foundation

struct Programlist: Codable {
    let list: List
}
    
struct List: Codable {
    let g1: [G1]
}
        
struct G1: Codable{
    let start_time: String
    let title: String
}
