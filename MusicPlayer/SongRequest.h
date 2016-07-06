//
//  SongRequest.h
//  MusicPlayer
//
//  Created by 屎里逃生 on 16/6/30.
//  Copyright © 2016年 屎里逃生. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol SongRequestDelegate<NSObject>
- (void)handlerData:(id)responseObj;
@end

@interface SongRequest : NSObject
@property (nonatomic,weak) id<SongRequestDelegate> delegate;
- (void)request:(NSString *)url;
- (void)request:(NSString *)url completehandler:(void(^)(id responseObjc))complete;
- (void)playSong:(NSString *)url ompletehandler:(void(^)(id responseObjc))complete;
@end
