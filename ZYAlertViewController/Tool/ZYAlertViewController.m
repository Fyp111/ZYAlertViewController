//
//  ZYAlertViewController.m
//  ZYSubscribeWallpaper
//
//  Created by fyp on 2019/5/17.
//  Copyright © 2019 fyp. All rights reserved.
//

#import "ZYAlertViewController.h"

typedef void(^DissmissHandler)(void);

@interface ZYAlertViewController ()

@property (nonatomic,strong,readwrite)UIView *alertView;
@property (nonatomic,strong,readwrite)UIView *backgroundView;
@property (nonatomic,assign)ZYAlertControllerStyle preferredStyle;
@property (nonatomic,strong)UIVisualEffectView *visualEffectView;
@property (nonatomic,copy)DissmissHandler dissmissHandler;

@end

@implementation ZYAlertViewController

+ (instancetype)showWithAlertView:(UIView *)alertView preferredStyle:(ZYAlertControllerStyle)preferredStyle dissmissCompletionHandler:(void(^)(void))dissmissHandler {
    return [[self alloc] initWithAlertView:alertView preferredStyle:preferredStyle dissmissCompletionHandler:dissmissHandler];
}


- (instancetype)initWithAlertView:(UIView *)alertView preferredStyle:(ZYAlertControllerStyle)preferredStyle dissmissCompletionHandler:(void(^)(void))dissmissHandler{
    self.providesPresentationContextTransitionStyle = true;
    self.definesPresentationContext = true;
    self.modalPresentationStyle = UIModalPresentationCustom;
    self.transitioningDelegate = self;
    self.alertView = alertView;
    self.preferredStyle = preferredStyle;
    self.makeVisualEffect = true;
    self.backgroundAlpha = 0.6;
    self.backgoundTapDismissEnable = true;
    self.dissmissHandler = dissmissHandler;
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addAlertView];
    [self addBackgroundView];
    [self addSingleTapGesture];
}

- (void)addBackgroundView {
    self.backgroundView = [UIView new];
    self.backgroundView.translatesAutoresizingMaskIntoConstraints = false;
    self.backgroundView.backgroundColor = [UIColor blackColor];
    [self.view insertSubview:self.backgroundView atIndex:0];
    [self addConstraintToView:self.backgroundView];
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    self.visualEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    self.visualEffectView.translatesAutoresizingMaskIntoConstraints = false;
    [self.backgroundView addSubview:self.visualEffectView];
    [self addConstraintToView:self.visualEffectView];
    if (!self.isMakeVisualEffect) {
        if (self.visualEffectView) {
            [self.visualEffectView removeFromSuperview];
        }
    }
    self.backgroundView.alpha = self.backgroundAlpha;
}

- (void)setMakeVisualEffect:(BOOL)makeVisualEffect {
    _makeVisualEffect = makeVisualEffect;
    if (!_makeVisualEffect) {
        if (self.visualEffectView) {
            [self.visualEffectView removeFromSuperview];
        }
    }
}

- (void)setBackgroundAlpha:(CGFloat)backgroundAlpha {
    _backgroundAlpha = backgroundAlpha;
    self.backgroundView.alpha = _backgroundAlpha;
}

- (void)setBackgoundTapDismissEnable:(BOOL)backgoundTapDismissEnable {
    _backgoundTapDismissEnable = backgoundTapDismissEnable;
}

- (void)addAlertView {
    self.alertView.userInteractionEnabled = true;
    [self.view addSubview:self.alertView];
    self.alertView.translatesAutoresizingMaskIntoConstraints = false;
    switch (self.preferredStyle) {
        case ZYAlertControllerStyleAlert:
            [self layoutAlertStyleView];
            break;
        case ZYAlertControllerStyleActionSheet:
            [self layoutActionSheetStyleView];
            break;
        default:
            break;
    }
}

- (void)layoutAlertStyleView {
    NSAssert(CGRectGetWidth(self.alertView.frame) < [UIScreen mainScreen].bounds.size.width,@"%s alertView不支持超出屏幕宽度",__func__);
    NSAssert(CGRectGetHeight(self.alertView.frame) < [UIScreen mainScreen].bounds.size.height, @"%s alertView不支持超出屏幕高度",__func__);
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.alertView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.alertView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
    if (!CGSizeEqualToSize(self.alertView.frame.size,CGSizeZero)) {
        [self.alertView addConstraint:[NSLayoutConstraint constraintWithItem:self.alertView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:0 multiplier:1 constant:CGRectGetWidth(self.alertView.frame)]];
        [self.alertView addConstraint:[NSLayoutConstraint constraintWithItem:self.alertView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:0 multiplier:1 constant:CGRectGetHeight(self.alertView.frame)]];
    }
    
}

- (void)layoutActionSheetStyleView {
    NSAssert(CGRectGetWidth(self.alertView.frame) <= [UIScreen mainScreen].bounds.size.width,@"%s alertView不支持超出屏幕宽度",__func__);
    NSAssert(CGRectGetHeight(self.alertView.frame) <= [UIScreen mainScreen].bounds.size.height, @"%s alertView不支持超出屏幕高度",__func__);
    for (NSLayoutConstraint *constraint in self.alertView.constraints) {
        if (constraint.firstAttribute == NSLayoutAttributeWidth) {
            [self.alertView removeConstraint: constraint];
            break;
        }
    }
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.alertView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.alertView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1 constant:UIEdgeInsetsZero.bottom]];
    if (CGRectGetWidth(self.alertView.frame) > 0 && CGRectGetHeight(self.alertView.frame) > 0 ) {
        [self.alertView addConstraint:[NSLayoutConstraint constraintWithItem:self.alertView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:0 multiplier:1 constant:CGRectGetWidth(self.alertView.frame)]];
        [self.alertView addConstraint:[NSLayoutConstraint constraintWithItem:self.alertView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:0 multiplier:1 constant:CGRectGetHeight(self.alertView.frame)]];
    }
}

#pragma mark - 为背景视图添加约束
- (void)addConstraintToView:(UIView *)view {
    if (view) {
        [view.superview addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:view.superview  attribute:NSLayoutAttributeTop multiplier:1 constant:UIEdgeInsetsZero.top]];
        [view.superview  addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:view.superview  attribute:NSLayoutAttributeLeft multiplier:1 constant:UIEdgeInsetsZero.left]];
        [view.superview  addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:view.superview  attribute:NSLayoutAttributeBottom multiplier:1 constant:UIEdgeInsetsZero.bottom]];
        [view.superview  addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:view.superview  attribute:NSLayoutAttributeRight multiplier:1 constant:UIEdgeInsetsZero.right]];
    }
}

- (void)addSingleTapGesture {
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissViewController)];
    self.backgroundView.userInteractionEnabled = true;
    [self.backgroundView addGestureRecognizer:tapGestureRecognizer];
}
                                    
- (void)dismissViewController {
    if (!self.backgoundTapDismissEnable) {
        return;
    }
    __weak typeof(self) weakSelf = self;
    [self dismissViewControllerAnimated:true completion:^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (strongSelf.dissmissHandler) {
            strongSelf.dissmissHandler();
        }
    }];
}


@end

@implementation ZYAlertViewController (AnimatedTransitioning)

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
     return [AlertAnimation alertAnimationIsPresenting:true preferredStyle:self.preferredStyle];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return [AlertAnimation alertAnimationIsPresenting:false preferredStyle:self.preferredStyle];
}

@end


@interface AlertAnimation ()

@property (nonatomic,assign,getter=isBeingPresented)BOOL beingPresented;
@property (nonatomic,assign)ZYAlertControllerStyle preferredStyle;

@end

@implementation AlertAnimation

+ (instancetype)alertAnimationIsPresenting:(BOOL)isBeingPresented preferredStyle:(ZYAlertControllerStyle)preferredStyle {
    return [[self alloc] alertAnimationIsPresenting:isBeingPresented preferredStyle:preferredStyle];
}

- (instancetype)alertAnimationIsPresenting:(BOOL)isBeingPresented preferredStyle:(ZYAlertControllerStyle)preferredStyle {
    self.beingPresented = isBeingPresented;
    self.preferredStyle= preferredStyle;
    return self;
}

- (NSTimeInterval)transitionDuration:(nullable id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.35;
}

- (void)animateTransition:(nonnull id<UIViewControllerContextTransitioning>)transitionContext {
    self.isBeingPresented?[self presentAnimateTransition:transitionContext]:[self dismissAnimateTransition:transitionContext];
}

- (void)presentAnimateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    ZYAlertViewController *alertController = (ZYAlertViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    alertController.backgroundView.alpha = 0.0;
    switch (self.preferredStyle) {
        case ZYAlertControllerStyleAlert:
            alertController.alertView.alpha = 0.0;
            alertController.alertView.transform = CGAffineTransformMakeScale(0.1, 0.1);
            break;
        case ZYAlertControllerStyleActionSheet:
            alertController.alertView.transform = CGAffineTransformMakeTranslation(0, CGRectGetHeight(alertController.alertView.frame));
            break;
        default:
            break;
    }
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:alertController.view];
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        alertController.backgroundView.alpha = alertController.backgroundAlpha;
        switch (alertController.preferredStyle) {
            case ZYAlertControllerStyleAlert:
                alertController.alertView.alpha = 1.0;
                alertController.alertView.transform = CGAffineTransformIdentity;
                break;
            case ZYAlertControllerStyleActionSheet:
                alertController.alertView.transform = CGAffineTransformIdentity;
                break;
            default:
                break;
        }
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
}

- (void)dismissAnimateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    ZYAlertViewController *alertController = (ZYAlertViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        alertController.backgroundView.alpha = 0.0;
        switch (self.preferredStyle) {
            case ZYAlertControllerStyleAlert:
                alertController.alertView.alpha = 0.0;
                alertController.alertView.transform = CGAffineTransformMakeScale(0.1, 0.1);
                break;
            case ZYAlertControllerStyleActionSheet:
                alertController.alertView.transform = CGAffineTransformMakeTranslation(0, CGRectGetHeight(alertController.alertView.frame));
                break;
            default:
                break;
        }
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
}

@end
