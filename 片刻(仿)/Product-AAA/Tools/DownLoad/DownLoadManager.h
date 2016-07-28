//
//  DownLoadManager.h
//  Product-A
//
//  Created by 吴峰磊 on 16/6/30.
//  Copyright © 2016年 吴峰磊. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DownLoad.h"
@interface DownLoadManager : NSObject



+(DownLoadManager *)defaultManager;

//创建一个下载任务
-(DownLoad *)creatDownload:(NSString *)url;



@end
