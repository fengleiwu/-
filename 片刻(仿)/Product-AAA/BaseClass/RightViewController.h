//
//  RightViewController.h
//  Product-AAA
//
//  Created by 吴峰磊 on 16/7/5.
//  Copyright © 2016年 吴峰磊. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger , MOVETYPE) {
    MOVETYPELEFT,
    MOVETYPERIGHT
};

@interface RightViewController : UIViewController

@property(nonatomic , strong)UILabel *titleLabel;
@property (nonatomic , strong)UIButton *button;

//hide or show

-(void)ChangeFrameWithType:(MOVETYPE)type;
@end
