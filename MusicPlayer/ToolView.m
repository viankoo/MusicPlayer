//
//  ToolView.m
//  MusicPlayer
//
//  Created by 屎里逃生 on 16/6/30.
//  Copyright © 2016年 屎里逃生. All rights reserved.
//

#import "ToolView.h"
#import "UIImageView+WebCache.h"
#import <AVFoundation/AVFoundation.h>
@interface ToolView()<AVAudioPlayerDelegate>
@property (nonatomic,strong) UIImageView *imgV;
@property (nonatomic,strong) UILabel *actorLabel;
@property (nonatomic,strong) UILabel *songLabel;
@property (nonatomic,strong) AVAudioPlayer *audioPlayer;
@end

@implementation ToolView
- (instancetype)init{
    self = [super init];
    if(self){
        self.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height-50, [UIScreen mainScreen].bounds.size.width, 50);
        _imgV = [[UIImageView alloc] init];
        _imgV.image = [UIImage imageNamed:@"album-default.jpg"];
        _actorLabel = [[UILabel alloc] init];
        _actorLabel.textColor = [UIColor whiteColor];
        _actorLabel.textAlignment  =  NSTextAlignmentLeft;
        _songLabel = [[UILabel alloc] init];
        _songLabel.textColor = [UIColor whiteColor];
        _songLabel.textAlignment  =  NSTextAlignmentLeft;
        _playButton = [[PlayButton alloc] initWithFrame:CGRectMake(257, 0, 50, 50)];
        [_playButton addTarget:self action:@selector(action) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_imgV];
        [self addSubview:_actorLabel];
        [self addSubview:_songLabel];
        [self addSubview:_playButton];
        
        //渐变背景
        CAGradientLayer *layer = [[CAGradientLayer alloc] init];
        layer.anchorPoint = CGPointMake(0, 0);
        layer.bounds = self.bounds;
        layer.colors = @[(__bridge id)[UIColor colorWithRed:0.0 green:51/255.0 blue:204/255.0 alpha:0.6].CGColor,(__bridge id)[UIColor colorWithRed:102/255.0 green:0/255.0 blue:255/255.0 alpha:0.6].CGColor];
        layer.locations = @[@(0),@(0.6)];
        layer.startPoint = CGPointMake(0, 0.5);
        layer.endPoint = CGPointMake(1,0.5);
        
        [self.layer insertSublayer:layer atIndex:0];
       
        
    }
    return self;
}

static CGFloat now = 0.0;
static NSTimer *timer;
- (void)play:(NSData *)data{
    _playButton.show = !_playButton.show;
    _audioPlayer  = [[AVAudioPlayer alloc] initWithData:data error:nil];
    _audioPlayer.delegate = self;
    [_audioPlayer play];
    timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(update) userInfo:nil repeats:YES];
    
}
- (void)update{
    NSLog(@"%f",_duration);
    now += 1;
    CGFloat percent = now / _duration;
    _playButton.percent = percent;
}

- (void)action{
    _playButton.show = !_playButton.show;
    if(_playButton.show){
        [_audioPlayer play];
        timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(update) userInfo:nil repeats:YES];
    }else{
        [_audioPlayer pause];
        [timer invalidate];
        timer = nil;
    }
}

- (void)clear{
    _playButton.show = NO;
    now = 0;
    _playButton.percent = 0.0;
    [timer invalidate];
    timer = nil;
}

#pragma mark AVAudioPlayerDelegate
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag{
    [self clear];
}

//设置子视图的frame
- (void)layoutSubviews{
    _imgV.frame = CGRectMake(2.5, 2.5, 45, 45);
    _actorLabel.frame = CGRectMake(50, 2.5, 205, 21);
    _songLabel.frame = CGRectMake(50, 26.5, 205, 21);
    
}

//setter
- (void)setImage:(NSString *)image{
    _image = image;
    [_imgV sd_setImageWithURL:[NSURL URLWithString:_image ] placeholderImage:[UIImage imageNamed:@"album-default.jpg"]];
}

- (void)setActorName:(NSString *)actorName{
    _actorName = actorName;
    _actorLabel.text = actorName;
}

- (void)setSongName:(NSString *)songName{
    _songName = songName;
    _songLabel.text = songName;
}

@end
