//
//  RightViewController.m
//  Product-AAA
//
//  Created by 吴峰磊 on 16/7/5.
//  Copyright © 2016年 吴峰磊. All rights reserved.
//

#import "RightViewController.h"
#import "MusicManager.h"
@interface RightViewController ()<UIGestureRecognizerDelegate>
@property (nonatomic , strong)UITapGestureRecognizer *tap;
@property (nonatomic , strong)UIPanGestureRecognizer *pan;
@end

@implementation RightViewController

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    
    
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"])
        
    {
        return NO;
        
    }
    if ([touch.view isKindOfClass:[UITableViewCell class]]) {
        return NO;
    }
    if ([touch.view isKindOfClass:[UICollectionViewCell class]]) {
        return NO;
    }
    return YES;
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIView *vertical = [[UIView alloc]initWithFrame:CGRectMake(40, 20, 1, kNviH)];
    vertical.backgroundColor = PkCOLOR(100, 100, 100);
    [self.view addSubview:vertical];
    UIView *horizontal = [[UIView alloc]initWithFrame:CGRectMake(0, 20 + kNviH - 1, kScreenWidth, 1)];
    horizontal.backgroundColor = [UIColor grayColor];
    //初始化边界平移手势
    UIScreenEdgePanGestureRecognizer *screenEdgePan = [[UIScreenEdgePanGestureRecognizer alloc]initWithTarget:self action:@selector(panWithFinger:)];
    //设置边界为左边界
    screenEdgePan.edges = UIRectEdgeLeft;
    self.tap.delegate=self;
    [self.view addSubview:self.button];
    [self.view addSubview:self.titleLabel];
    [self.view addGestureRecognizer:self.tap];
    [self.view addSubview:horizontal];
    [self.view addGestureRecognizer:screenEdgePan];
    [self.view addGestureRecognizer:self.pan];
    
    NSLog(@"%@",self);

    
    // Do any additional setup after loading the view.
}




#pragma mark --- 属性 ----
-(UIButton *)button{
    if (!_button) {
        _button = [[UIButton alloc]initWithFrame:CGRectMake(10, 20 + 10, 20, 20)];
        [_button setTitle:@"三" forState:(UIControlStateNormal)];
        [_button setTitleColor:PkCOLOR(25, 25, 25) forState:(UIControlStateNormal)];
        [_button addTarget:self action:@selector(showRootVC:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _button;
}

-(UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(40, 20 + 10, 200, 20)];
        _titleLabel.font = [UIFont systemFontOfSize:18];
        _titleLabel.textColor = PkCOLOR(25, 25, 25);
        
    }
    return _titleLabel;
}

-(UITapGestureRecognizer *)tap{
    if (!_tap) {
        _tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideRootVC:)];
    }
    return _tap;
}

-(UIPanGestureRecognizer *)pan{
    if (!_pan) {
        _pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panShowRootVC:)];
        _pan.enabled = NO;
        
    }
    return _pan;
}









#pragma mark -- 抽屉

-(void)showRootVC:(UIButton *)sender
{
    [self ChangeFrameWithType:MOVETYPERIGHT];
}

-(void)hideRootVC:(UITapGestureRecognizer *)sender{
    [self ChangeFrameWithType:MOVETYPELEFT];
}


-(void)panWithFinger:(UIScreenEdgePanGestureRecognizer *)sender
{
    CGPoint point = [sender locationInView:self.navigationController.view.superview];
    NSLog(@"%@",NSStringFromCGPoint(point));
    
    CGRect newFrame = self.navigationController.view.frame;
    newFrame.origin.x = point.x;
    [self constrainNewFrame:&newFrame];
    self.navigationController.view.frame = newFrame;
    if (sender.state == UIGestureRecognizerStateEnded) {
        [self ChangeFrameWithType:MOVETYPERIGHT];
    }
}

-(void)panShowRootVC:(UIPanGestureRecognizer *)sender
{
    CGPoint point = [sender locationInView:self.navigationController.view.superview];
    NSLog(@"%@",NSStringFromCGPoint(point));
    CGRect newFrame = self.navigationController.view.frame;
    newFrame.origin.x = point.x;
    [self constrainNewFrame:&newFrame];

    self.navigationController.view.frame = newFrame;
    if (sender.state == UIGestureRecognizerStateEnded) {
        [self ChangeFrameWithType:MOVETYPELEFT];
    }
    
    
}

//约束坐标
-(void)constrainNewFrame:(CGRect *)newFrame
{
    if (newFrame->origin.x >= kScreenWidth - kMoveDistance) {
        newFrame->origin.x = kScreenWidth - kMoveDistance;
    }else if (newFrame->origin.x <= 0){
        newFrame->origin.x = 0;
    }
}



//根据类型移动
-(void)ChangeFrameWithType:(MOVETYPE)type
{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"key" object:self userInfo:nil];
    //获取当前的self.navigationController.view.frame
    CGRect newFrame = self.navigationController.view.frame;
    if (type == MOVETYPELEFT) {
        newFrame.origin.x = 0;
        self.button.userInteractionEnabled = YES;
        self.tap.enabled = NO;
        self.pan.enabled = NO;
    }else if (type == MOVETYPERIGHT) {
        //改变他的坐标原点
        self.tap.enabled = YES;
        self.button.userInteractionEnabled = NO;
        self.pan.enabled = YES;
        newFrame.origin.x = kScreenWidth - kMoveDistance;
    }
    //给个动画0.5s
    [UIView animateWithDuration:0.5 animations:^{
        self.navigationController.view.frame = newFrame;
    } completion:nil];
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
