//
//  Interaction.h
//  MusicPlayer
//
//  Created by 屎里逃生 on 16/6/30.
//  Copyright © 2016年 屎里逃生. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Interaction : UIPercentDrivenInteractiveTransition
@property (nonatomic,assign,readonly) BOOL interacting;
- (void)prepareForViewController:(UIViewController *)viewController;


@end
