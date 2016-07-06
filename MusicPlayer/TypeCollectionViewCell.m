//
//  TypeCollectionViewCell.m
//  MusicPlayer
//
//  Created by 屎里逃生 on 16/6/30.
//  Copyright © 2016年 屎里逃生. All rights reserved.
//

#import "TypeCollectionViewCell.h"
@interface TypeCollectionViewCell()
@property (nonatomic,strong) UIImageView *imageV;
@end

@implementation TypeCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        _imageV = [[UIImageView alloc] init];
        _imageV.contentMode = UIViewContentModeScaleAspectFit;
        //加圆角
        self.layer.cornerRadius = 5;
        self.layer.masksToBounds = YES;
        //加阴影
        self.layer.shadowColor = [UIColor blackColor].CGColor;//阴影颜色
        self.layer.shadowOffset = CGSizeMake(4, 4);//阴影偏移，与shadowRadius配合使用
        self.layer.shadowRadius = 4;//阴影半径，默认3
        self.layer.shadowOpacity  = 0.8;//阴影透明度，默认0
        [self addSubview:_imageV];
        
    }
    return self;
}

- (void)layoutSubviews{
    _imageV.frame = self.bounds;
    
}

- (void)setImage:(UIImage *)image{
    _image = image;
    _imageV.image = image;
}
@end
