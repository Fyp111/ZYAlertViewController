//
//  ZYShareView.h
//  ZYSubscribeWallpaper
//
//  Created by fyp on 2019/5/17.
//  Copyright © 2019 fyp. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class ZYShareView;
@protocol ZYShareViewDelegate<NSObject>

//
- (void)shareClickwithindex:(NSInteger)index;
@end

@interface ZYShareView : UIView<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic ,copy) void(^okBlock)(void);
@property (nonatomic, weak) id<ZYShareViewDelegate>delegate;
@property (nonatomic ,strong) UILabel *title;
@property (nonatomic ,strong) UICollectionView *collectionView;
@property (nonatomic ,strong) UIButton *closeBtn;
@property (nonatomic ,strong) NSArray *dataArray;
@end

NS_ASSUME_NONNULL_END
