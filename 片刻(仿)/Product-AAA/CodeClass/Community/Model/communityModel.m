//
//  communityModel.m
//  Product-AAA
//
//  Created by 吴峰磊 on 16/7/5.
//  Copyright © 2016年 吴峰磊. All rights reserved.
//

#import "communityModel.h"

@implementation communityModel



-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

+(NSMutableArray *)arr:(NSDictionary *)dic
{
    NSMutableArray *arr1 = [NSMutableArray array];
    NSDictionary *data = dic[@"data"];
    NSArray *list = data[@"list"];
    for (NSDictionary *dic2 in list) {
        communityModel *model = [[communityModel alloc]init];
        [model setValuesForKeysWithDictionary:dic2];
        NSDictionary *dic3 = dic2[@"counterList"];
        [model setValuesForKeysWithDictionary:dic3];
        NSDictionary *dic4 = dic2[@"userinfo"];
        [model setValuesForKeysWithDictionary:dic4];
        [arr1 addObject:model];
    }
    return arr1;
}

@end
