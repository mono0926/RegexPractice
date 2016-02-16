//: [Previous](@previous)

import Foundation
import XCPlayground
import PySwiftyRegex

//: 改行入り文字列の先頭マッチがうまく検出出来ない(書き方の問題？)のため、断念（´・ω・｀）

let dirs = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true) as? [String]

let file = "part3_source.rb"
let path = (XCPSharedDataDirectoryPath as NSString).stringByAppendingPathComponent(file)
let source = try! String(contentsOfFile: path)

//: # スペースやタブ文字の入った空行を見つける

re.findall(" +", source)
// 検出されない…。
re.findall("^ +", source)
//: $ は ^ の反対で、「行末」を意味するメタ文字（アンカー）です。
//: つまり、^ +$ は「行頭から行末までスペースが1文字以上続く」という意味になります。
re.findall("^ +$", source)
re.findall("^[ \t]+$", source)


//: [Next](@next)
