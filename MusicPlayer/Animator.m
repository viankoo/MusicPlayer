//
//  Animator.m
//  MusicPlayer
//
//  Created by 屎里逃生 on 16/6/30.
//  Copyright © 2016年 屎里逃生. All rights reserved.
//

#import "Animator.h"

@implementation Animator
//返回动画执行时间
- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext{
    return 0.8;
}

//动画的执行
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    
    //获取转换的两个场景
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    //获取容器
    UIView *container = [transitionContext containerView];
    
    
    //获取本来toV的frame
    CGRect finalFrame = [transitionContext finalFrameForViewController:toVC];
    //获取动画时间
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    
    //转场的动画过程
    
    
    if(toVC.isBeingPresented){
        [container addSubview:toVC.view];
        toVC.view.frame = CGRectOffset(finalFrame, 50, -450);
        [UIView animateWithDuration:duration delay:0 usingSpringWithDamping:0.2 initialSpringVelocity:0 options:nil animations:^{
            toVC.view.frame = CGRectOffset(finalFrame, 50, 50);
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:YES];
        }];
        
    }
    if(fromVC.isBeingDismissed){
        [container sendSubviewToBack:toVC.view];
        [UIView animateWithDuration:duration animations:^{
            fromVC.view.frame = CGRectOffset(finalFrame, 50, finalFrame.size.height) ;
        } completion:^(BOOL finished) {
            BOOL isComplete = ![transitionContext transitionWasCancelled];
            [transitionContext completeTransition:isComplete];
        }];
    }
    
}

@end
