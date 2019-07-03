//
//  ViewController.m
//  ZYAlertViewController
//
//  Created by fyp on 2019/7/3.
//  Copyright © 2019 fyp. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor cyanColor];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    ZYShareView *shareView = [[ZYShareView alloc]initWithFrame:CGRectMake(0, 0, ZY_SCREEN_WIDTH, ZY_HEIGHT(157))];
    ZYAlertViewController * alert = [ZYAlertViewController showWithAlertView:shareView preferredStyle:ZYAlertControllerStyleActionSheet dissmissCompletionHandler:^{
    }];
    
    shareView.okBlock = ^{
        [alert dismissViewControllerAnimated:YES completion:nil];
    };
    alert.backgroundAlpha = 0.5;
    alert.backgoundTapDismissEnable = YES;
    alert.makeVisualEffect = YES;
    [self presentViewController:alert animated:true completion:^{
    }];
}

@end
