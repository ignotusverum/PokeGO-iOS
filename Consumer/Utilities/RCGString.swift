//
//  RCGString.swift
//  Consumer
//
//  Created by Vladislav Zagorodnyuk on 7/22/16.
//  Copyright © 2016 Vlad Z. All rights reserved.
//

extension String {
    
    func sliceFrom(start: String, to: String) -> String? {
        return (rangeOfString(start)?.endIndex).flatMap { sInd in
            (rangeOfString(to, range: sInd..<endIndex)?.startIndex).map { eInd in
                substringWithRange(sInd..<eInd)
            }
        }
    }
}
