//
//  RadioDetailModel.m
//  Product-AAA
//
//  Created by 吴峰磊 on 16/7/5.
//  Copyright © 2016年 吴峰磊. All rights reserved.
//

#import "RadioDetailModel.h"

@implementation RadioDetailModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

//@property(nonatomic , strong)NSString *uname;//标题
//@property(nonatomic , strong)NSString *title;
//@property(nonatomic , strong)NSString *icon;//中间小头像
//@property(nonatomic , strong)NSString *musicUrl;
//@property(nonatomic , strong)NSString *musicVisit;
//@property(nonatomic , strong)NSString *imgUrl;
//@property(nonatomic , strong)NSString *coverimg;//标题对应图片和最上面图片
//@property(nonatomic , strong)NSString *webview_url;
//@property(nonatomic , strong)NSString *musicvisitnum;//中间访问人数
//@property(nonatomic , strong)NSString *desc;//中间简介

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.imgUrl forKey:@"imgUrl"];
    [aCoder encodeObject:self.webview_url forKey:@"webview_url"];
    [aCoder encodeObject:self.musicUrl forKey:@"musicUrl"];
    [aCoder encodeObject:self.title forKey:@"title"];
    [aCoder encodeObject:self.icon forKey:@"icon"];
    [aCoder encodeObject:self.uname forKey:@"uname"];
    [aCoder encodeObject:self.coverimg forKey:@"coverimg"];
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        self.title = [aDecoder decodeObjectForKey:@"title"];
        self.imgUrl = [aDecoder decodeObjectForKey:@"imgUrl"];
        self.webview_url = [aDecoder decodeObjectForKey:@"webview_url"];
        self.musicUrl = [aDecoder decodeObjectForKey:@"musicUrl"];
        self.icon = [aDecoder decodeObjectForKey:@"icon"];
        self.coverimg = [aDecoder decodeObjectForKey:@"coverimg"];
        self.uname = [aDecoder decodeObjectForKey:@"uname"];
    }
    return self;
}



+(NSMutableArray *)arr1:(NSDictionary *)dic
{
    NSMutableArray *arr2 = [NSMutableArray array];
    NSDictionary *dic1 = dic[@"data"];
    NSDictionary *dic2 = dic1[@"radioInfo"];
    RadioDetailModel *model = [[RadioDetailModel alloc]init];
    [model setValuesForKeysWithDictionary:dic2];
    [arr2 addObject:model];
    return arr2;
}

+(NSMutableArray *)arr2:(NSDictionary *)dic
{
    NSMutableArray *arr1 = [NSMutableArray array];
    NSDictionary *dic1 = dic[@"data"];
    NSDictionary *dic2 = dic1[@"radioInfo"];
    RadioDetailModel *model = [[RadioDetailModel alloc]init];
    [model setValuesForKeysWithDictionary:dic2];
    NSDictionary *dic3 = dic2[@"userinfo"];
    [model setValuesForKeysWithDictionary:dic3];
    [arr1 addObject:model];
    return arr1;
    
    
}




+(NSMutableArray *)arr3:(NSDictionary *)dic
{
    NSMutableArray *arr1 = [NSMutableArray array];
    NSDictionary *dic1 = dic[@"data"];
    NSArray *arr2 = dic1[@"list"];
    for (NSDictionary *dic2 in arr2) {
        RadioDetailModel *model = [[RadioDetailModel alloc]init];
        [model setValuesForKeysWithDictionary:dic2];
        NSDictionary *dic5 = dic2[@"playInfo"];
        [model setValuesForKeysWithDictionary:dic5];
        NSDictionary *dic3 = dic5[@"authorinfo"];
        [model setValuesForKeysWithDictionary:dic3];
        NSDictionary *dic4 = dic5[@"shareinfo"];
        [model setValuesForKeysWithDictionary:dic4];
        MusicDownloadTable *table = [[MusicDownloadTable alloc]init];
        NSArray *arr6 = [table selectAll];
        NSLog(@"+++++++++++%@",arr6);
        NSLog(@"**************%@",model.musicUrl);
        if ([arr6 containsObject:model.musicUrl]) {
            model.downType = downLoaded;
        }else{
            model.isDownLoad = NO;
        }
        model.isDownLoad = YES;
        [arr1 addObject:model];
    }
    return arr1;
}

@end
