//
//  ArrayManager.h
//  Product-AAA
//
//  Created by 吴峰磊 on 16/7/6.
//  Copyright © 2016年 吴峰磊. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ArrayManager : NSObject

@property(nonatomic , strong)NSMutableArray *Array;


+(ArrayManager *)shareManager;


@end
