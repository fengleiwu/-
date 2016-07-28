//
//  ReadDetailModel.h
//  Product-AAA
//
//  Created by 吴峰磊 on 16/7/5.
//  Copyright © 2016年 吴峰磊. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReadDetailModel : NSObject
@property(nonatomic , strong)NSString *name;
@property(nonatomic , strong)NSString *coverimg;
@property(nonatomic , strong)NSString *title;
@property(nonatomic , strong)NSString *content;
@property(nonatomic , strong)NSString *myID;


+(NSMutableArray *)arr:(NSDictionary *)dic;

@end
