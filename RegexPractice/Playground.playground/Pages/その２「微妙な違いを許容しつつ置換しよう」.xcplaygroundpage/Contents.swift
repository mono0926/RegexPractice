//: [Previous](@previous)

import UIKit
import PySwiftyRegex

//: # カタカナ語の表記の揺れを許容する

let reviewText = "クープバゲットのパンは美味しかった。" +
"今日はクープ バゲットさんに行きました。" +
"クープ　バゲットのパンは最高。" +
"ジャムおじさんのパン、ジャムが入ってた。" +
"また行きたいです。クープ・バゲット。" +
"クープ・バケットのパン、売り切れだった（><）"
re.findall("クープ バゲット", reviewText)

//: ## さまざまな区切り文字を許容する

re.findall("クープ[ 　・]バゲット", reviewText)
//: ## 濁点の有無を許容する

re.findall("クープ[ 　・]バ[ゲケ]ット", reviewText)

//: ## 区切り文字の有無を許容する

//: **「～が1文字、または無し」を表現するためには ? というメタ文字を使います。（文字量を指定するので 量指定子 のひとつです）**

re.findall("クープ[ 　・]?バ[ゲケ]ット", reviewText)

//: ## 区切り文字を簡易的に表現する

//: **正規表現にはちょうど「任意の1文字」を表す . というメタ文字（文字クラス）があります。**

re.findall("クープ.?バ[ゲケ]ット", reviewText)

//: # HTMLタグをCSVへ変換する

let html = "<select name=\"game_console\">\n" +
"<option value=\"wii_u\">Wii U</option>\n" +
"<option value=\"ps4\">プレステ4</option>\n" +
"<option value=\"gb\">ゲームボーイ</option>\n" +
"</select>"

//: ## valueを抜き出す正規表現を考える

//: **「直前の文字が 1文字以上 」を表す場合は + というメタ文字（量指定子）を使います。**

re.findall("value=\"[a-z0-9_]+\"", html)

//: ## 表示テキストを抜き出す正規表現を考える

//: **「直前の文字が 1文字以上 」を表す場合は + というメタ文字（量指定子）を使います。**

re.findall(">.+<", html)

//: ## 1. 行全体にマッチする正規表現を作る

re.findall("<option value=\"[a-z0-9_]+\">.+</option>", html)
//: ## 2. valueと表示テキストの部分をそれぞれ ( ) で囲んでキャプチャする

re.finditer("<option value=\"([a-z0-9_]+)\">(.+)</option>", html).forEach { $0.group([1,2]).forEach { print($0) } }

//: ## 3. キャプチャを利用して新しい文字列を組み立てる

re.sub("<option value=\"([a-z0-9_]+)\">(.+)</option>", "$1,$2", html)


//: # 表示テキストがないoptionも置換できるようにする

let html2 = "<select name=\"game_console\">\n" +
    "<option value=\"none\"></option>\n" +
    "<option value=\"wii_u\">Wii U</option>\n" +
    "<option value=\"ps4\">プレステ4</option>\n" +
    "<option value=\"gb\">ゲームボーイ</option>\n" +
"</select>"

re.sub("<option value=\"([a-z0-9_]+)\">(.*)</option>", "$1,$2", html2)

//: # selectedになっているoptionも置換できるようにする

let html3 = "<select name=\"game_console\">\n" +
    "<option value=\"none\"></option>\n" +
    "<option value=\"wii_u\" selected>Wii U</option>\n" +
    "<option value=\"ps4\">プレステ4</option>\n" +
    "<option value=\"gb\">ゲームボーイ</option>\n" +
"</select>"

re.sub("<option value=\"([a-z0-9_]+)\"( selected)?>(.*)</option>", "$1,$2", html3)

//: **( selected)をキャプチャ対象から除外**
re.sub("<option value=\"([a-z0-9_]+)\"(?: selected)?>(.*)</option>", "$1,$2", html3)

//: ## [a-z0-9_]+ を \w に置き換える

//: **RubyやJavaScriptでは「\w = [a-zA-Z0-9_]（半角英数字とアンダースコア1文字） 」という仕様になっています。**

re.sub("<option value=\"(\\w+)\"(?: selected)?>(.*)</option>", "$1,$2", html3)

//: # 重要： * と + は「貪欲」であることに注意！

//: **改行を外すと崩れる**
let html4 = "<select name=\"game_console\">" +
    "<option value=\"none\"></option>" +
    "<option value=\"wii_u\" selected>Wii U</option>" +
    "<option value=\"ps4\">プレステ4</option>" +
    "<option value=\"gb\">ゲームボーイ</option>" +
"</select>"
re.sub("<option value=\"(\\w+)\"(?: selected)?>(.*)</option>", "$1,$2", html4)

//: ## 解決策１：「任意の1文字」よりも厳しい条件を指定する

//: **[ ] の最初に ^ が入ると否定の意味に変わるのです。**

re.sub("<option value=\"(\\w+)\"(?: selected)?>([^<]*)</option>", "$1,$2", html4)

//: **解決策２：最短のマッチを返すように指定する

//: **?を加えることで最初に見つかった < で終わるようにする**

re.sub("<option value=\"(\\w+)\"(?: selected)?>(.*?)</option>", "$1,$2", html4)


//: [Next](@next)
