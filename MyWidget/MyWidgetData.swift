import SwiftUI

private let APP_GROUP_ID = "group.com.bowen"
let appGroupUserDefaults = UserDefaults(suiteName: APP_GROUP_ID)!
// 获取主app保存的体重
var appGroupWeight: String {
    return appGroupUserDefaults.string(forKey: "weight") ?? "--"
}
// 获取主app保存的身高
var appGroupHeight: String {
    return appGroupUserDefaults.string(forKey: "height") ?? "--"
}

// Widget可以使用和主App相同的翻译文件
func CommonLocalizabledString(key: String, comment: String) -> String {
    let path = Bundle.main.path(forResource: "zh-Hans", ofType: "lproj") ?? ""
    return Bundle(path: path)?.localizedString(forKey: key, value: "", table: "CommonLocalizable") ?? comment
}
