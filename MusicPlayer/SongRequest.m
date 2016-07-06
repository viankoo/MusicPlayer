//
//  SongRequest.m
//  MusicPlayer
//
//  Created by 屎里逃生 on 16/6/30.
//  Copyright © 2016年 屎里逃生. All rights reserved.
//

#import "SongRequest.h"
#import "AFNetworking.h"
@implementation SongRequest
- (void)request:(NSString *)url{
    //内部创建NSURLSession ,并且设置默认config
    //设置代理，监听回调
    //代理方法是放入一个队列中执行
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if([self.delegate respondsToSelector:@selector(handlerData:)]){
            [self.delegate handlerData:responseObject];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}

- (void)request:(NSString *)url completehandler:(void (^)(id))complete{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        complete(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    
}

- (void)playSong:(NSString *)url ompletehandler:(void(^)(id responseObjc))complete{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSURL *URL = [NSURL URLWithString:url];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    NSURLSessionDownloadTask *task = [manager downloadTaskWithRequest:request progress:nil destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        NSURL *cacheURL = [[NSFileManager defaultManager] URLForDirectory:NSCachesDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        NSLog(@"%@",cacheURL.path);
        return [cacheURL URLByAppendingPathComponent: [NSString stringWithString:response.suggestedFilename.stringByRemovingPercentEncoding]];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        //获取下载后的数据
        complete([NSData dataWithContentsOfURL:filePath]);
    }];
    
    [task resume];
    
    
    
    
}

- (NSString *)checkCache:(NSString *)url indict:(NSDictionary *)dict{
    for(NSString *key in [dict allKeys]){
        if([url isEqualToString:key]){
            return dict[url];
        }
    }
    return nil;
}
@end
