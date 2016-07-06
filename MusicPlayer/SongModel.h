//
//  SongModel.h
//  MusicPlayer
//
//  Created by 屎里逃生 on 16/6/30.
//  Copyright © 2016年 屎里逃生. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SongModel : NSObject
@property (nonatomic ,copy) NSString *author;
@property (nonatomic ,copy) NSString *title;
@property (nonatomic ,copy) NSString *pic_big;
@property (nonatomic ,copy) NSString *pic_small;
@property (nonatomic ,copy) NSString *song_id;

- (instancetype)initWithDict:(NSDictionary * )dict;
+ (instancetype)SongWithDict:(NSDictionary *)dict;

@end
