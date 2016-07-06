//
//  Interaction.m
//  MusicPlayer
//
//  Created by 屎里逃生 on 16/6/30.
//  Copyright © 2016年 屎里逃生. All rights reserved.
//

#import "Interaction.h"
@interface Interaction()
@property (nonatomic,weak) UIViewController *presentedVC;
@property (nonatomic,assign) BOOL shouldComplete;
@end
@implementation Interaction
- (void)prepareForViewController:(UIViewController *)viewController{
    
    _presentedVC = viewController;
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
    [viewController.view addGestureRecognizer:pan];
}

//手势操作UIGestureRecognizerStateBegan
- (void)panAction:(UIPanGestureRecognizer *)pan{
    CGPoint translation = [pan translationInView:pan.view.superview];
    CGFloat percent = 0.0;
    switch (pan.state) {
        case UIGestureRecognizerStateBegan:
            _interacting = YES;
            [_presentedVC dismissViewControllerAnimated:YES completion:nil];
            break;
        case UIGestureRecognizerStateChanged:
            percent = translation.y /_presentedVC.view.bounds.size.height;
            [self updateInteractiveTransition:percent];
            _shouldComplete = (percent > 0.3);
            break;
        case UIGestureRecognizerStateCancelled:
            _interacting = NO;
            [self cancelInteractiveTransition];
            break;
        case UIGestureRecognizerStateEnded:
            _interacting = NO;
            if (_shouldComplete) {
                [self finishInteractiveTransition];
            }else{
                [self cancelInteractiveTransition];
            }
            break;
    }
    
//上拉刷新

}
@end
