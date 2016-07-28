//
//  MusicDownloadTable.h
//  Product-AAA
//
//  Created by 吴峰磊 on 16/7/5.
//  Copyright © 2016年 吴峰磊. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DBManager.h"
@interface MusicDownloadTable : NSObject
@property(nonatomic , strong)FMDatabase *dataBase;

//建表
-(void)creatTable;
//插入
-(void)insertIntoTable:(NSArray *)Info;
//取出
-(NSArray *)selectAll;
@end
