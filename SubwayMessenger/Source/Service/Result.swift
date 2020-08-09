//
//  Result.swift
//  SubwayMessenger
//
//  Created by 엄태형 on 2020/08/09.
//  Copyright © 2020 Taehyeong. All rights reserved.
//

import Foundation

enum Result<T> {
    case success(T)
    case failure(Data?, Error)
}
