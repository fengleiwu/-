//
//  RadioDetailViewController.h
//  Product-AAA
//
//  Created by 吴峰磊 on 16/7/5.
//  Copyright © 2016年 吴峰磊. All rights reserved.
//

#import "RightViewController.h"

@interface RadioDetailViewController : RightViewController
@property(nonatomic , strong)NSString *url;
@property(nonatomic , strong)NSString *tit;

@property(nonatomic , assign)BOOL isSearch;

@end
