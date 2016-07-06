//
//  SongModel.m
//  MusicPlayer
//
//  Created by 屎里逃生 on 16/6/30.
//  Copyright © 2016年 屎里逃生. All rights reserved.
//

#import "SongModel.h"

@implementation SongModel
- (instancetype)initWithDict:(NSDictionary * )dict{
    self = [super init];
    if(self){
        self.author = dict[@"author"];
        self.title = dict[@"title"];
        self.pic_big = dict[@"pic_big"];
        self.pic_small = dict[@"pic_small"];
        self.song_id = dict[@"song_id"];
    }
    return self;
}

+ (instancetype)SongWithDict:(NSDictionary *)dict{
    return [[SongModel alloc] initWithDict:dict];
}

@end
