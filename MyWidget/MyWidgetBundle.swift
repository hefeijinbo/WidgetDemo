//
//  MyWidgetBundle.swift
//  WidgetDemo
//
//  Created by jinbo on 2023/5/3.
//

import SwiftUI

// @main 是Widget Extension 进程的入口地址
// WidgetBundle 用于定义多个Page的Widget
@main
struct MyWidgetBundle: WidgetBundle {
    var body: some Widget {
        widgets()
    }

    func widgets() -> some Widget {
        return WidgetBundleBuilder.buildBlock(MyWidgetRectangular(), MyWidgetCircular(index: 0), MyWidgetCircular(index: 1))
    }
}

