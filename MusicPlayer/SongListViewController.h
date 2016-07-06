//
//  SongListViewController.h
//  MusicPlayer
//
//  Created by 屎里逃生 on 16/6/30.
//  Copyright © 2016年 屎里逃生. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SongModel;
@protocol SongListViewControllerDelegate <NSObject>

- (void)playSongWithModel:(SongModel *)model;

@end

@interface SongListViewController : UIViewController
@property (nonatomic,strong) UIImage *image;
@property (nonatomic,copy) NSArray *songlist;
@property (nonatomic,weak) id<SongListViewControllerDelegate> delegate;
@end
