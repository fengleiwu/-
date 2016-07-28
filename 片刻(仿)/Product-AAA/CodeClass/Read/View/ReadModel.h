//
//  ReadModel.h
//  Product-AAA
//
//  Created by 吴峰磊 on 16/7/5.
//  Copyright © 2016年 吴峰磊. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReadModel : NSObject
@property(nonatomic , strong)NSString *img;
@property(nonatomic , strong)NSString *url;

@property(nonatomic , strong)NSString *coverimg;
@property(nonatomic , strong)NSString *name;
@property(nonatomic , strong)NSString *enname;
@property(nonatomic , assign)NSInteger type;


+(NSMutableArray *)arr:(NSDictionary *)dic;
+(NSMutableArray *)arr1:(NSDictionary *)dic1;
@end
