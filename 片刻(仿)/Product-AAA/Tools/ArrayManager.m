//
//  ArrayManager.m
//  Product-AAA
//
//  Created by 吴峰磊 on 16/7/6.
//  Copyright © 2016年 吴峰磊. All rights reserved.
//

#import "ArrayManager.h"

@implementation ArrayManager



+(ArrayManager *)shareManager
{
    static ArrayManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[ArrayManager alloc]init];
    });
    return manager;
}

-(instancetype)init
{
    self = [super init];
    if (self) {
        self.Array = [NSMutableArray array];
    }
    return self;
}


@end
