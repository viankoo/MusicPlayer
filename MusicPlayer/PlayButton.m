//
//  PlayButton.m
//  MusicPlayer
//
//  Created by 屎里逃生 on 16/6/30.
//  Copyright © 2016年 屎里逃生. All rights reserved.
//

#import "PlayButton.h"
@interface PlayButton()
@property (nonatomic,strong) UIBezierPath *circle1;
@property (nonatomic,strong) UIBezierPath *circle2;
@property (nonatomic,strong) UIBezierPath *line1;
@property (nonatomic,strong) UIBezierPath *line2;
@property (nonatomic,strong) UIBezierPath *line3;
@property (nonatomic,strong) UIBezierPath *line4;
@property (nonatomic,assign) CGRect rect;
@property (nonatomic,strong) CABasicAnimation *basic;
@end

@implementation PlayButton
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        _show = NO;
        _rect = frame;
        
        self.layer.shouldRasterize = YES;
        
        _circle1 = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(5, 5, frame.size.width-5*2, frame.size.height-5*2)];
        
        _circle2 = [UIBezierPath bezierPathWithArcCenter:CGPointMake(frame.size.width/2, frame.size.height/2) radius:(frame.size.width-10)/2 startAngle:0 endAngle:0 clockwise:YES];
        
        
        _line2 = [UIBezierPath bezierPath];
        [_line2 moveToPoint:CGPointMake(15, 15)];
        [_line2 addLineToPoint:CGPointMake(15, frame.size.height-15)];
        
        _line4 = [UIBezierPath bezierPath];
        [_line4 moveToPoint:CGPointMake(frame.size.width-15, 15)];
        [_line4 addLineToPoint:CGPointMake(frame.size.width-15, frame.size.height-15)];
        
        _line1 = [UIBezierPath bezierPath];
        [_line1 moveToPoint:CGPointMake(15, 15)];
        [_line1 addLineToPoint:CGPointMake(_rect.size.width-15, _rect.size.height/2)];
        _line3 = [UIBezierPath bezierPath];
        [_line3 moveToPoint:CGPointMake(15, _rect.size.height-15)];
        [_line3 addLineToPoint:CGPointMake(_rect.size.width-15, _rect.size.height/2)];
    }
    return self;
}



- (void)drawRect:(CGRect)rect{
    [[UIColor colorWithRed:102/255.0 green:1.0 blue:102/255.0 alpha:1.0] setStroke];
    [_circle1 stroke];
    [_line1 stroke];
    [_line2 stroke];
    [_line3 stroke];
    [_line4 stroke];
    
    [[UIColor yellowColor] setStroke];
    _circle2.lineWidth = 3;
    [_circle2 stroke];
    
}

//setter
- (void)setShow:(BOOL)show{
    //NSLog(@"%d",show);
    _show = show;
    if(_show){
        _line1 = [UIBezierPath bezierPath];
        [_line1 moveToPoint:CGPointMake(15, 15)];
        [_line1 addLineToPoint:CGPointMake(_rect.size.width-15, 15)];
        _line3 = [UIBezierPath bezierPath];
        [_line3 moveToPoint:CGPointMake(15, _rect.size.height-15)];
        [_line3 addLineToPoint:CGPointMake(_rect.size.width-15, _rect.size.height-15)];
        
        [self setNeedsDisplay];
    }else{
        
        
        _line1 = [UIBezierPath bezierPath];
        [_line1 moveToPoint:CGPointMake(15, 15)];
        [_line1 addLineToPoint:CGPointMake(_rect.size.width-15, _rect.size.height/2)];
        _line3 = [UIBezierPath bezierPath];
        [_line3 moveToPoint:CGPointMake(15, _rect.size.height-15)];
        [_line3 addLineToPoint:CGPointMake(_rect.size.width-15, _rect.size.height/2)];
        
        [self setNeedsDisplay];
    }
}

- (void)setPercent:(CGFloat)percent{
    CGFloat angle = percent * M_PI *2;
    _circle2 = [UIBezierPath bezierPathWithArcCenter:CGPointMake(_rect.size.width/2, _rect.size.height/2) radius:(_rect.size.width-10)/2 startAngle:0 endAngle:angle clockwise:YES];
    [self setNeedsDisplay];
}
@end
