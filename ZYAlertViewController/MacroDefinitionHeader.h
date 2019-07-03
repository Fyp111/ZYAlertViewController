//
//  MacroDefinitionHeader.h
//  iOSProcessModule
//
//  Created by sunyan on 2019/3/2.
//  Copyright © 2019年 Shenyang ZongYi technology co., LTD. All rights reserved.
//

#ifndef MacroDefinitionHeader_h
#define MacroDefinitionHeader_h

//iphonex系列判断

#define ZY_IPHONEX_SERIES ({\
BOOL isXSeries = false;\
if ([UIScreen instancesRespondToSelector:@selector(currentMode)]) {\
    if (CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size)) {\
    isXSeries = true;\
}else if (CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size)) {\
    isXSeries = true;\
}else if (CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size)) {\
    isXSeries = true;\
}else {\
    if ([[UIApplication sharedApplication] statusBarFrame].size.height > 20.0) {\
        isXSeries = true;\
        }\
    }\
}else{\
    isXSeries = false;\
}\
    isXSeries;\
})

//普通适配
#define ZY_SCREEN_WIDTH   [UIScreen mainScreen].bounds.size.width
#define ZY_SCREENH_HEIGHT [UIScreen mainScreen].bounds.size.height

#define BASE_WIDTH ((ZY_SCREENH_HEIGHT == 567.0f || ZY_SCREENH_HEIGHT == 896.0f) ? (375.0f * 1.1):(isPad?(1024.0f): 414.0f))
#define BASE_HEIGHT ((ZY_SCREENH_HEIGHT == 567.0f || ZY_SCREENH_HEIGHT == 896.0f) ?(567.0f * 1.1):(isPad?(768.0f): 736.0f))

//按比例计算的宽和高
#define ZY_WIDTH(NSInteger) (double)NSInteger / BASE_WIDTH  * ZY_SCREEN_WIDTH
#define ZY_HEIGHT(NSInteger) (double)NSInteger / BASE_HEIGHT * ZY_SCREENH_HEIGHT

//tabbar高度
#define ZY_TABBAR_HEIGHT  (ZY_IPHONEX_SERIES ? (49.f+34.f) : 49.f)

//导航栏and状态栏高度
#define ZY_STATUSBARANDNAVIGATIONBAR_HEIGHT        (ZY_IPHONEX_SERIES ? 88.f : 64.f)

//状态栏高度
#define ZY_STATUSBAR_HEIGHT        (ZY_IPHONEX_SERIES ? 44.f : 20.f)

// 是否iPad
#define someThing (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)? ipad: iphone
#define isPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

//创建粗体字
#define SYSBOLD_FONT(num) [UIFont fontWithName:@"Arial-BoldMT" size:ZY_HEIGHT(num)]

//系统字体大小
#define SYS_FONT(num) [UIFont systemFontOfSize:ZY_HEIGHT(num)]


//判断字段时候为空的情况
#define IF_NULL_TO_STRING(x) ([(x) isEqual:[NSNull null]]||(x)==nil)? @"":TEXT_STRING(x)

//转换为字符串
#define TEXT_STRING(x) [NSString stringWithFormat:@"%@",x]

#define SHOWHUD               MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];hud.mode = MBProgressHUDModeIndeterminate;

#define HIDENHUD              [MBProgressHUD hideHUDForView:self.view animated:YES];

//正式地址
#define APP_HOST     @"http://sub.zywallpaper.com/ZYSubscriptionWallpaper/api/v1/"

//测试地址
//#define APP_HOST     @"http://172.28.60.97:8100/ZYSubscriptionWallpaper/api/v1/"

//分享链接地址
#define ShareUrl     @"https://itunes.apple.com/app/id1460438271?mt=8"

//本机唯一标识
#define UDID              [[[UIDevice currentDevice] identifierForVendor] UUIDString]

//缩写
#define kKeyWindow          [UIApplication sharedApplication].keyWindow

//颜色
#define     UIColorFromHex(hexrgb, al)        [UIColor colorWithRed:((float)((hexrgb & 0xFF0000) >> 16))/255.0 green:((float)((hexrgb & 0xFF00) >> 8))/255.0 blue:((float)(hexrgb & 0xFF))/255.0 alpha:al]

//app 主色调
#define ZY_MainColor   UIColorFromHex(0x212121, 1)

//纵艺key
#define ZONGYIKey                           @"cfb02b8490f34a51a0f50fe0ee8d69d9"

//内购
#define INAPPPRIVATEKEY                     @"26f256c6ee384a48bb640f3dcf92107e"

//汉语判断
#define isChinese         [[[[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"] objectAtIndex:0] rangeOfString:@"zh-Hans"].location != NSNotFound

#define isZhHant          [[[NSLocale preferredLanguages] firstObject] isEqualToString:@"zh-Hant"]

//本地语言适配
#define ZYLocal(string)    NSLocalizedString(string, nil)

//下载过的数组
#define INFORMATIONSDOWNLOADPATH  [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] 

//图片网址加密key
#define AESKEY @"ZYKJSW2019-05-09"

#define TIPS(string)          TipsView *alert = [[TipsView alloc] initWithTitle:string];[alert show];

#define PROMPT(string)          PromptView *tip = [[PromptView alloc] initWithTitle:string];[tip show];

#ifndef zy_dispatch_queue_async_safe
#define zy_dispatch_queue_async_safe(queue, block)\
if (strcmp(dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL), dispatch_queue_get_label(queue)) == 0) {\
block();\
} else {\
dispatch_async(queue, block);\
}
#endif

#ifndef zy_dispatch_main_sync_safe
#define zy_dispatch_main_sync_safe(block) zy_dispatch_queue_async_safe(dispatch_get_main_queue(), block)
#endif

//

#import "ZYShareView.h"
#import "ZYAlertViewController.h"

static NSString* const kURL_Reachability__Address=@"www.baidu.com";
#endif /* MacroDefinitionHeader_h */
