//
//  ShareViewCollectionViewCell.h
//  ZYSubscribeWallpaper
//
//  Created by fyp on 2019/5/17.
//  Copyright © 2019 fyp. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ShareViewCollectionViewCell : UICollectionViewCell
@property (nonatomic ,strong) UIImageView *icon;
@property (nonatomic ,strong) UILabel *title;
@property (nonatomic ,strong) NSDictionary *model;
@end

NS_ASSUME_NONNULL_END
