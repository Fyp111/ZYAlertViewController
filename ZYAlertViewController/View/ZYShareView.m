//
//  ZYShareView.m
//  ZYSubscribeWallpaper
//
//  Created by fyp on 2019/5/17.
//  Copyright © 2019 fyp. All rights reserved.
//

#import "ZYShareView.h"
#import "ShareViewCollectionViewCell.h"

@implementation ZYShareView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = UIColorFromHex(0x2d2d2d, 1);
        [self creatUI];
        self.dataArray = @[@{@"icon":@"ZYShareView_weixin",@"title":@"we chat"},@{@"icon":@"ZYShareView_friendcircle",@"title":@"Comments"},@{@"icon":@"ZYShareView_QQ",@"title":@"QQ"},@{@"icon":@"ZYShareView_sina",@"title":@"Sina"}];
    }
    return self;
}

- (void)closeClick{
    if (self.okBlock) {
        self.okBlock();
    }
}

- (void)creatUI{

    _title = [[UILabel alloc]init];
    _title.font = SYS_FONT(16);
    _title.text = @"分享";
    _title.textColor = [UIColor lightTextColor];
    _title.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_title];
    
    _closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_closeBtn addTarget:self action:@selector(closeClick) forControlEvents:UIControlEventTouchUpInside];
    [_closeBtn setImage:[UIImage imageNamed:@"vip_Close"] forState:UIControlStateNormal];
    [self addSubview:_closeBtn];
    
    [self addSubview:self.collectionView];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    _title.frame = CGRectMake((ZY_SCREEN_WIDTH - ZY_WIDTH(200))*0.5, ZY_HEIGHT(23), ZY_WIDTH(200), ZY_HEIGHT(16));
    _closeBtn.frame = CGRectMake(ZY_SCREEN_WIDTH - ZY_HEIGHT(45), ZY_HEIGHT(20), ZY_HEIGHT(20), ZY_HEIGHT(20));
}

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        
        CGFloat ITEMW = ZY_HEIGHT(48);
        CGFloat margin = (ZY_SCREEN_WIDTH - ITEMW*4)/5;
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(ITEMW, ITEMW+ZY_HEIGHT(30));
        layout.sectionInset = UIEdgeInsetsMake(0, margin, 0, margin);
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = margin;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, ZY_HEIGHT(55), ZY_SCREEN_WIDTH, ITEMW+ZY_HEIGHT(30)) collectionViewLayout:layout];
        _collectionView.backgroundColor = UIColorFromHex(0x2d2d2d, 1);
        _collectionView.scrollEnabled = NO;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        [_collectionView registerClass:[ShareViewCollectionViewCell class] forCellWithReuseIdentifier:@"ShareViewCollectionViewCell"];
    }
    return _collectionView;
}


#pragma mark - UICollectionViewDataSource

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ShareViewCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ShareViewCollectionViewCell" forIndexPath:indexPath];
    cell.model = self.dataArray[indexPath.item];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if ([_delegate respondsToSelector:@selector(shareClickwithindex:)]) {
        [_delegate shareClickwithindex:indexPath.item];
    }
}


@end
