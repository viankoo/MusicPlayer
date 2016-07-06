//
//  SongListViewController.m
//  MusicPlayer
//
//  Created by 屎里逃生 on 16/6/30.
//  Copyright © 2016年 屎里逃生. All rights reserved.
//

#import "SongListViewController.h"
#import "SongModel.h"
#import "UIImageView+WebCache.h"
@interface SongListViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UIImageView *header;
@property (nonatomic,strong) UITableView *songList;
@end

@implementation SongListViewController
- (instancetype)init{
    self = [super init];
    if(self){
        self.view.bounds = CGRectMake(0, 0, 220, 450);
        self.view.layer.shadowColor = [UIColor blackColor].CGColor;
        self.view.layer.shadowOffset = CGSizeMake(-2, -2);
        self.view.layer.shadowRadius = 4;
        self.view.layer.shadowOpacity  = 0.8;
        
        self.view.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _header = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 220, 100)];
    _header.backgroundColor = [UIColor grayColor];
    
    _songList = [[UITableView alloc] initWithFrame:CGRectMake(0, 100, 220, 350) style:UITableViewStylePlain];
    _songList.backgroundColor = [UIColor greenColor];
    _songList.showsVerticalScrollIndicator = NO;
    _songList.dataSource = self;
    _songList.delegate = self;
    [self.view addSubview:_header];
    [self.view addSubview:_songList];
    
}


#pragma  mark - datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.songlist.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"songCell"];
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"songCell"];
    }
    cell.backgroundColor = [UIColor colorWithRed:135/255.0 green:206/255.0 blue:235/255.0 alpha:0.6];
    
    SongModel *model = self.songlist[indexPath.row];
    cell.textLabel.text = model.title;
    cell.detailTextLabel.text = model.author;
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:model.pic_small] placeholderImage:[UIImage imageNamed:@"placeholder" ]];
    
    return cell;
}

#pragma mark delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat y = scrollView.contentOffset.y;
    if(y<0){
        _header.frame = CGRectMake(0,0,220, 100-y);
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if([self.delegate respondsToSelector:@selector(playSongWithModel:)]){
        [self.delegate playSongWithModel:self.songlist[indexPath.row]];
    }
}


- (void)setImage:(UIImage *)image{
    _image = image;
    _header.image = image;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (BOOL)prefersStatusBarHidden{
    return YES;
}
@end
