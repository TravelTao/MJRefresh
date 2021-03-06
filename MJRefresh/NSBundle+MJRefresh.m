//
//  NSBundle+MJRefresh.m
//  MJRefreshExample
//
//  Created by MJ Lee on 16/6/13.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "NSBundle+MJRefresh.h"
#import "MJRefreshComponent.h"


@implementation NSBundle (MJRefresh)
+ (instancetype)mj_refreshBundle
{
    static NSBundle *refreshBundle = nil;
    if (refreshBundle == nil) {
        // 这里不使用mainBundle是为了适配pod 1.x和0.x
        refreshBundle = [NSBundle bundleWithPath:[[NSBundle bundleForClass:[MJRefreshComponent class]] pathForResource:@"MJRefresh" ofType:@"bundle"]];
    }
    return refreshBundle;
}

+ (UIImage *)mj_arrowImage
{
    static UIImage *arrowImage = nil;
    if (arrowImage == nil) {
        arrowImage = [[UIImage imageWithContentsOfFile:[[self mj_refreshBundle] pathForResource:@"arrow@2x" ofType:@"png"]] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    }
    return arrowImage;
}

+ (NSString *)mj_localizedStringForKey:(NSString *)key
{
    NSString * language = [[NSUserDefaults standardUserDefaults] objectForKey:@"XCDefaultAppLanguage"];
    NSString * o = [self mj_localizedStringForKey:key value:nil];
    return o;
}

+ (NSString *)mj_localizedStringForKey:(NSString *)key value:(NSString *)value
{
    // MARK: TODO - Improve performance here
    @autoreleasepool {
//    static NSBundle *bundle = nil;
//    if (bundle == nil) {
        // （iOS获取的语言字符串比较不稳定）目前框架只处理en、zh-Hans、zh-Hant三种情况，其他按照系统默认处理
        NSBundle * bundle;
        NSString * language;
        language = [[NSUserDefaults standardUserDefaults] objectForKey:@"XCDefaultAppLanguage"];
        if ([language isEqualToString:@""]) {
            language = @"zh-Hans";
        }

        // 从MJRefresh.bundle中查找资源
        bundle = [NSBundle bundleWithPath:[[NSBundle mj_refreshBundle] pathForResource:language ofType:@"lproj"]];
//    }
        value = [bundle localizedStringForKey:key value:value table:nil];
        return [[NSBundle mainBundle] localizedStringForKey:key value:value table:nil];
    }
}
@end
