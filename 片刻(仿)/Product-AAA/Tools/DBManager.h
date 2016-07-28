//
//  DBManager.h
//  Product-A
//
//  Created by 吴峰磊 on 16/6/30.
//  Copyright © 2016年 吴峰磊. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DBManager : NSObject

@property(nonatomic , strong)FMDatabase *dataBase;
+(DBManager *)shareManager;

//关闭数据库
-(void)close;

@end
