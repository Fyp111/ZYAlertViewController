//
//  ZYAlertViewController.h
//  ZYSubscribeWallpaper
//
//  Created by fyp on 2019/5/17.
//  Copyright © 2019 fyp. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, ZYAlertControllerStyle) {
    /** 中心弹出 */
    ZYAlertControllerStyleAlert = 0,
    /** 底部弹出 */
    ZYAlertControllerStyleActionSheet
};

@interface ZYAlertViewController : UIViewController

/**
 * 将要弹出的自定义视图
 */
@property (nonatomic,strong,readonly)UIView *alertView;
/**
 * 背景视图
 */
@property (nonatomic,strong,readonly)UIView *backgroundView;
/**
 * 背景视图透明度
 */
@property (nonatomic,assign)CGFloat backgroundAlpha;
/**
 * 包含黑色模糊效果(包含/不包含)
 */
@property (nonatomic,assign,getter=isMakeVisualEffect)BOOL makeVisualEffect;
/**
 * 点击背景消失的(手势启动/禁用)
 */
@property (nonatomic,assign)BOOL backgoundTapDismissEnable;
/**
 * 展示自定义视图
 *
 * @param alertView 自定义视图
 * @param preferredStyle 弹出模式
 * @param dissmissHandler 弹出视图控制器消失回调
 * @return ZYAlertViewController实例对象
 *
 */
+ (instancetype)showWithAlertView:(UIView *)alertView preferredStyle:(ZYAlertControllerStyle)preferredStyle dissmissCompletionHandler:(void(^)(void))dissmissHandler;

@end

@interface ZYAlertViewController (AnimatedTransitioning)<UIViewControllerTransitioningDelegate>

@end

@interface AlertAnimation : NSObject<UIViewControllerAnimatedTransitioning>

+ (instancetype)alertAnimationIsPresenting:(BOOL)isBeingPresented preferredStyle:(ZYAlertControllerStyle)preferredStyle;

@end

NS_ASSUME_NONNULL_END
