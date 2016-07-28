//
//  RequestManager.m
//  18UILessonCocoapods
//
//  Created by 吴峰磊 on 16/6/16.
//  Copyright © 2016年 吴峰磊. All rights reserved.
//

#import "RequestManager.h"

@implementation RequestManager


+(void)requestWithUrlString:(NSString *)urlString parDic:(NSDictionary *)parDic requestType:(RequestType)requestType finish:(Finish)finish error:(Error)error
{
    RequestManager *manager = [[RequestManager alloc]init];
    [manager requestWithUrlString:urlString parDic:parDic requestType:requestType finish:finish error:error];
}


-(void)requestWithUrlString:(NSString *)urlString parDic:(NSDictionary *)parDic requestType:(RequestType)requestType finish:(Finish)finish error:(Error)error;
{
    //block赋值
    self.finish = finish;
    self.error = error;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    if (requestType == RequestGET) {
        [manager GET:urlString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            [self finishRequestReturnMainThread:responseObject];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            self.error(error);
        }];
        return;
        
         }
    [manager POST:urlString parameters:parDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self finishRequestReturnMainThread:responseObject];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        self.error(error);
    }];

}

-(void)finishRequestReturnMainThread:(NSData *)data
{
    dispatch_async(dispatch_get_main_queue(), ^{
        self.finish(data);
    });
}


@end
