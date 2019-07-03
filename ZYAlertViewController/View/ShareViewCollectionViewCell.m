//
//  ShareViewCollectionViewCell.m
//  ZYSubscribeWallpaper
//
//  Created by fyp on 2019/5/17.
//  Copyright © 2019 fyp. All rights reserved.
//

#import "ShareViewCollectionViewCell.h"

@implementation ShareViewCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self creatUI];
    }
    return self;
}

- (void)creatUI{
    
    _icon = [[UIImageView alloc]init];
    [self.contentView addSubview:_icon];
    
    _title = [[UILabel alloc]init];
    _title.textColor = [UIColor whiteColor];
    _title.font = SYS_FONT(14);
    _title.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_title];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    _icon.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.width);
    _title.frame = CGRectMake(0, self.bounds.size.width+ZY_HEIGHT(10), self.bounds.size.width, ZY_HEIGHT(20));
}

-(void)setModel:(NSDictionary *)model{
    _model = model;
    _title.text = _model[@"title"];
    _icon.image = [UIImage imageNamed:_model[@"icon"]];
}

@end
