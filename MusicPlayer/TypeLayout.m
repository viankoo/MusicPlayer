//
//  TypeLayout.m
//  MusicPlayer
//
//  Created by 屎里逃生 on 16/6/30.
//  Copyright © 2016年 屎里逃生. All rights reserved.
//

#import "TypeLayout.h"
#define SCREENW [UIScreen mainScreen].bounds.size.width
@interface TypeLayout()
@property (nonatomic,assign) CGFloat cellHeight;
@property (nonatomic,assign) CGFloat cellWidth;
@property (nonatomic,assign) CGFloat margin;
@property (nonatomic,assign) NSUInteger colnum;
@property (nonatomic,assign) NSUInteger numOfItems;
@end

@implementation TypeLayout
//布局前准备
- (void)prepareLayout{
    _numOfItems = [self.collectionView numberOfItemsInSection:0];
    _colnum = 3;
    _margin = 10;
    _cellWidth = ( SCREENW - _margin * (_colnum + 1) ) / _colnum;
    _cellHeight = _cellWidth;
    
}

//整个界面大小
- (CGSize)collectionViewContentSize{
    int count = (int)ceil(_numOfItems*1.0 / _colnum)
    ;
    CGFloat height = count * _cellHeight + (count+1)*_margin;
    return CGSizeMake(SCREENW, height);
}

//可见区域的布局
- (nullable NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    NSMutableArray *attrs = [NSMutableArray array];
    for(int i=0;i<_numOfItems;i++){
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes *attr = [self layoutAttributesForItemAtIndexPath:indexPath];
        [attrs addObject:attr];
    }
    return attrs;
}

//每一个item的布局
- (nullable UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewLayoutAttributes *attr = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    int row = (int)indexPath.item / _colnum;
    int col = (int)indexPath.item % _colnum;
    int x = _margin + (_margin + _cellWidth) * col;
    int y = _margin + (_margin + _cellHeight) * row;
    attr.frame = CGRectMake(x, y, _cellWidth, _cellHeight);
    return attr;
}
@end
