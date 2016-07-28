//
//  ReadDetailModel.m
//  Product-AAA
//
//  Created by 吴峰磊 on 16/7/5.
//  Copyright © 2016年 吴峰磊. All rights reserved.
//

#import "ReadDetailModel.h"

@implementation ReadDetailModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        self.myID = value;
    }
}


+(NSMutableArray *)arr:(NSDictionary *)dic
{
    NSMutableArray *arr1 = [NSMutableArray array];
    NSDictionary *dic1 = dic[@"data"];
    NSArray *arr2 = dic1[@"list"];
    for (NSDictionary *dic2 in arr2) {
        ReadDetailModel *model = [[ReadDetailModel alloc]init];
        [model setValuesForKeysWithDictionary:dic2];
        [arr1 addObject:model];
    }
    return arr1;
}

@end
