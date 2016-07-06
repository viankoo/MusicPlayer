//
//  ToolView.h
//  MusicPlayer
//
//  Created by 屎里逃生 on 16/6/30.
//  Copyright © 2016年 屎里逃生. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlayButton.h"
@interface ToolView : UIView
@property (nonatomic,strong) NSString *image;
@property (nonatomic,copy) NSString *actorName;
@property (nonatomic,copy) NSString *songName;
@property (nonatomic,strong) PlayButton *playButton;
@property (nonatomic,assign) NSTimeInterval duration;
- (void)play:(NSData *)data;
- (void)clear;
@end
