//
//  MyWidgetRectangular.swift
//  MyWidget
//
//  Created by jinbo on 2023/5/3.
//

import WidgetKit
import SwiftUI
import Intents

// 为小组件展示提供一切必要信息的结构体
struct MyWidgeRectangularProvider: IntentTimelineProvider {
    // 占位视图, 例如网络请求失败、发生未知错误、第一次展示小组件都会展示这个view
    func placeholder(in context: Context) -> MyWidgeRectangularEntry {
        MyWidgeRectangularEntry()
    }
    // 快照 编辑屏幕在左上角选择添加Widget  第一次展示时会调用该方法
    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (MyWidgeRectangularEntry) -> ()) {
        completion(MyWidgeRectangularEntry())
    }
    // 生成一个事件线，更新数据&&进行数据的预处理，转化成Entry
    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        let timeline = Timeline(entries: [MyWidgeRectangularEntry()], policy: .atEnd)
        completion(timeline)
    }
}
// Widget 数据源
struct MyWidgeRectangularEntry: TimelineEntry {
    var date: Date = Date()
    var weightValue = ""
    var heightValue = ""
    init() {
        weightValue = appGroupWeight
        heightValue = appGroupHeight
    }
}

private let textDefaultColor = Color(red: 199.0 / 255, green: 203.0 / 255, blue: 231.0 / 255)

// widget 展示视图
struct MyWidgetEntryView : View {
    var entry: MyWidgeRectangularEntry
    @Environment(\.widgetFamily) var family // 尺寸环境变量
    
    var body: some View {
        let imageSize:CGFloat = 20
        let mediumFontSize: CGFloat = 12
        let bigFontSize:CGFloat = 18
        return VStack(alignment: .leading, spacing: 3) {
            Image("widget_logo").resizable().frame(width: 58, height: 20).aspectRatio(contentMode: .fit)
            HStack {
                VStack(alignment: .leading, spacing: 0) {
                    Text("体重").font(.system(size: mediumFontSize)).foregroundColor(textDefaultColor)
                    HStack(alignment:.lastTextBaseline, spacing: 0) {
                        Text(entry.weightValue).font(.system(size: bigFontSize)).foregroundColor(Color.blue)
                    }.frame(height: imageSize + 5)
                }
                VStack(alignment: .leading, spacing: 0) {
                    Text("身高").font(.system(size: mediumFontSize)).foregroundColor(textDefaultColor)
                    HStack(alignment:.lastTextBaseline, spacing: 0) {
                        Text(String(entry.heightValue)).font(.system(size: bigFontSize)).foregroundColor(Color.blue)
                    }
                }
            }
        }
    }
}
struct MyWidgetRectangular: Widget {
    let kind: String = "MyWidgetRectangular"
    var body: some WidgetConfiguration {
        let configuration = IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: MyWidgeRectangularProvider()) { entry in
            MyWidgetEntryView(entry: entry).widgetURL(URL(string:"widget://")!)
        }
        .configurationDisplayName(CommonLocalizabledString(key: "widget_data", comment: "My Data")) // 添加组件时组件title
        return configuration.supportedFamilies([.accessoryRectangular])
    }
}
