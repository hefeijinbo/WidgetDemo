//
//  MyWidgetCircularWidget.swift
//  MyWidget
//
//  Created by jinbo on 2023/3/30.
//  Copyright © 2023. All rights reserved.
//

import Foundation
import SwiftUI
import WidgetKit

// 为小组件展示提供一切必要信息的结构体
struct MyWidgetCircularProvider: IntentTimelineProvider {
    let index: Int
    init(index: Int) {
        self.index = index
    }
    // 占位视图, 例如网络请求失败、发生未知错误、第一次展示小组件都会展示这个view
    func placeholder(in context: Context) -> MyWidgetCircularEntry {
        MyWidgetCircularEntry(index: index)
    }
    // 快照 编辑屏幕在左上角选择添加Widget  第一次展示时会调用该方法
    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (MyWidgetCircularEntry) -> ()) {
        completion(MyWidgetCircularEntry(index: index))
    }
    // 生成一个事件线，更新数据&&进行数据的预处理，转化成Entry
    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        let timeline = Timeline(entries: [MyWidgetCircularEntry(index: index)], policy: .atEnd)
        completion(timeline)
    }
}

struct MyWidgetCircularEntry: TimelineEntry {
    var date: Date = Date()
    let index: Int
    init(index: Int) {
        self.index = index
    }
}

@available(iOSApplicationExtension 16.0, *)
struct MyWidgetCircularWidgetEntryView : View {
    var entry: MyWidgetCircularEntry
    @Environment(\.widgetFamily) var family // 尺寸环境变量
    
    var body: some View {
        VStack(spacing: 2) {
            HStack() {
                Image(entry.index == 0 ? "widget_activity" : "widget_switch").resizable().frame(width: 20, height: 20).foregroundColor(Color.black)
            }.frame(width: 30, height: 30).background(Color(white: 220.0/255.0)).cornerRadius(15)
            Text(entry.index == 0 ? "活动" : "开关").font(.system(size: 10)).lineLimit(1).padding(.zero).frame(alignment: .center)
        }.frame(width: 120, height: 120).background(Color(white: 40.0/255.0)).cornerRadius(60)
    }
}

@available(iOSApplicationExtension 16.0, *)
struct MyWidgetCircular: Widget {
    init() {
        
    }
    
    var index = 0
    var kind: String = ""
    var body: some WidgetConfiguration {
        // widget URL定义点击widget后的回调,在AppDelegate的application:openURL:中收到回调
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: MyWidgetCircularProvider(index: index)) { entry in
            MyWidgetCircularWidgetEntryView(entry: entry).widgetURL(URL(string:kind)!)
        }
        .configurationDisplayName(index == 0 ? "活动" : "开关")
        .supportedFamilies([.accessoryCircular])
    }
    
    init(index: Int) {
        self.index = index
        kind = "MyWidgetCircularWidget" + String(index)
    }
}
