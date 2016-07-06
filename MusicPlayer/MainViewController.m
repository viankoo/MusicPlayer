//
//  MainViewController.m
//  MusicPlayer
//
//  Created by 屎里逃生 on 16/6/30.
//  Copyright © 2016年 屎里逃生. All rights reserved.
//

#import "MainViewController.h"
#import "ToolView.h"
#import "TypeLayout.h"
#import "TypeCollectionViewCell.h"
#import "SongListViewController.h"
#import "Animator.h"
#import "Interaction.h"
#import "SongRequest.h"
#import "SongModel.h"
@interface MainViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UIViewControllerTransitioningDelegate,
SongRequestDelegate,SongListViewControllerDelegate>
{
    NSArray *_typeArray;
}
@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) ToolView *toolView;
@property (nonatomic,strong) Animator *animator;
@property (nonatomic,strong) Interaction *interaction;

@property (nonatomic,strong) SongRequest *songReuqest;
@end

@implementation MainViewController
static NSString * const reuseIdentifier = @"TypeCell";
- (void)viewDidLoad {
    [super viewDidLoad];
    //初始化数据
    _typeArray = @[@(1),@(2),@(11),@(12),@(16),@(21),@(22),@(23),@(24),@(25)];
    
    _songReuqest = [[SongRequest alloc] init];
    _songReuqest.delegate = self;
    //设置转场
    _animator = [Animator new];
    _interaction = [Interaction new];
    //设置View
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - 60) collectionViewLayout:[[TypeLayout alloc] init]];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.backgroundColor = [UIColor clearColor];
    [self.collectionView registerClass:[TypeCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    _toolView = [[ToolView alloc] init];
    
    
    
    [self.view addSubview:_collectionView];
    [self.view addSubview:_toolView];
    
    //渐变背景
    CAGradientLayer *layer = [[CAGradientLayer alloc] init];
    layer.anchorPoint = CGPointMake(0, 0);
    layer.bounds = CGRectMake(0, 0, 320, 568);
    layer.borderWidth = 0;
    layer.colors = @[(__bridge id)[UIColor whiteColor].CGColor,(__bridge id)[UIColor colorWithRed:240/255.0 green:255/255.0 blue:255/255.0 alpha:1.0].CGColor];
    layer.locations = @[@(0),@(0.4)];
    layer.startPoint = CGPointMake(0.5, 0);
    layer.endPoint = CGPointMake(0.5, 1);
    
    [self.view.layer insertSublayer:layer atIndex:0];
    
 //   [self setupUpRefresh];
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return _typeArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TypeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    //设置cell的内容
    cell.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d_small.png",[_typeArray[indexPath.item] intValue]]];
    cell.type = [_typeArray[indexPath.item] intValue];
    return cell;
}

#pragma mark <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSString *url = [NSString stringWithFormat:@"http://tingapi.ting.baidu.com/v1/restserver/ting?method=baidu.ting.billboard.billList&type=%d&size=10&offset=0",[_typeArray[indexPath.item] intValue]];
        [_songReuqest request:url completehandler:^(id responseObjc) {
        NSDictionary *dict = responseObjc;
        NSArray *songlist = dict[@"song_list"];
        NSMutableArray *temp = [NSMutableArray array];
        for(NSDictionary *dict in songlist){
            SongModel *songModel = [SongModel SongWithDict:dict];
            [temp addObject:songModel];
        }
        
        SongListViewController *slvc = [[SongListViewController alloc] init];
        slvc.delegate = self;
        slvc.songlist = [temp copy];
        //设置custom 可以同时看见
        slvc.modalPresentationStyle = UIModalPresentationCustom;
        slvc.transitioningDelegate = self;
        slvc.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d_small.png",[_typeArray[indexPath.item] intValue]]];
            
        [_interaction prepareForViewController:slvc];
        [self presentViewController:slvc animated:YES completion:nil];
    }];
    
}

#pragma mark  <UIViewControllerTransitioningDelegate>
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    return _animator;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    return _animator;
}

- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator{
    return _interaction.interacting?_interaction:nil;
}


#pragma mark SongListViewControllerDelegate
- (void)playSongWithModel:(SongModel *)model{
    //改变ToolView
    _toolView.songName = model.title;
    _toolView.actorName = model.author;
    _toolView.image = model.pic_small;
    //播放音乐请求
    NSString *url = [NSString stringWithFormat:@"http://tingapi.ting.baidu.com/v1/restserver/ting?method=baidu.ting.song.play&songid=%@",model.song_id];
    [_songReuqest request:url completehandler:^(id responseObjc) {
        NSDictionary *dict = responseObjc[@"bitrate"];
        NSTimeInterval duration = [dict[@"file_duration"] integerValue];
        NSString *mp3Link = dict[@"file_link"];
        
        //获取音乐路径之后，要再次请求，下载歌曲
        [_songReuqest playSong:mp3Link ompletehandler:^(id responseObjc){
            //播放音乐
            _toolView.duration = duration;
            [_toolView clear];
            [_toolView play:responseObjc];
        }];
    }];
}
- (BOOL)prefersStatusBarHidden{
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
@end
