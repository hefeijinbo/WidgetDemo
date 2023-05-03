//
//  AppGroupUtil.swift
//
//  Created by jinbo on 2023/3/29.
//  Copyright © 2023. All rights reserved.
//

import Foundation
import WidgetKit

private let APP_GROUP_ID = "group.com.bowen" // 和Entitlements中定义的ID必须一致
// App Group 用于主进程和Extension进程(Widget)共享数据的主要方式
public class AppGroupUtil: NSObject {
    private static let MyWidgetKind = "MyWidgetRectangular"
    
    // 保存数据到AppGroup中
    public static func save(data: String, dataType: String) {
        if #available(iOS 14.0, *) {
            let userDefaults = UserDefaults(suiteName: APP_GROUP_ID)!
            userDefaults.set(data, forKey: dataType)
            userDefaults.synchronize()
        }
    }
    // 刷新Widget
    @objc public static func reloadWidget(kind: String) {
        if #available(iOS 14.0, *) {
            WidgetCenter.shared.reloadTimelines(ofKind: kind)
        }
    }
    @objc public static func saveWeight(value: String) {
        save(data: value, dataType: "weight")
        reloadWidget(kind: MyWidgetKind)
    }
    
    @objc public static func saveHeight(value: String) {
        save(data: value, dataType: "height")
        reloadWidget(kind: MyWidgetKind)
    }
    
    @objc public static func clearAllValues() {
        saveWeight(value: "--")
        saveHeight(value: "--")
        reloadWidget(kind: MyWidgetKind)
    }
}
