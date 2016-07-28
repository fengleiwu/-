//
//  pinglunViewController.m
//  Product-AAA
//
//  Created by 吴峰磊 on 16/7/5.
//  Copyright © 2016年 吴峰磊. All rights reserved.
//

#import "pinglunViewController.h"
#import "pinglunTableViewCell.h"
#import "pinglunModel.h"
#import "RequestManager.h"
@interface pinglunViewController ()<UITableViewDataSource , UITableViewDelegate , UITextViewDelegate>
@property (nonatomic , strong)NSMutableArray *arr;
@property (nonatomic , strong)UITableView *tab;
@property (nonatomic , strong)UIButton *btn;
@property (nonatomic , strong)UIButton *panBtn;
@property (nonatomic , strong)UITextField *tf;
@property (nonatomic , assign)NSInteger inter;
@property (nonatomic , strong)UIView *tfView;
@property (nonatomic , assign)BOOL isEdit;
@property(nonatomic , strong)UITextView *myTextView;

@end

@implementation pinglunViewController

-(UITextView *)myTextView
{
    if (!_myTextView) {
        _myTextView = [[UITextView alloc]initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, 40)];
        _myTextView.backgroundColor = PkCOLOR(170, 180, 200);
        _myTextView.delegate = self;
        _myTextView.returnKeyType = UIReturnKeySend;
        
    }
    return _myTextView;
}




-(UIButton *)button{
    if (!_btn) {
        _btn = [[UIButton alloc]initWithFrame:CGRectMake(10, 20 + 10, 20, 20)];
        [_btn setImage:[UIImage imageNamed:@"u9_start"] forState:(UIControlStateNormal)];
        [_btn setTitleColor:PkCOLOR(25, 25, 25) forState:(UIControlStateNormal)];
        [_btn addTarget:self action:@selector(back) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _btn;
}
-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)creatTopView
{
    self.panBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.panBtn.frame = CGRectMake(kScreenWidth / 2 + 50, 30, 20, 20);
    [self.panBtn setImage:[UIImage imageNamed:@"edit"] forState:(UIControlStateNormal)];
    [self.panBtn addTarget:self action:@selector(panAction) forControlEvents:(UIControlEventTouchUpInside)];
    self.panBtn.tintColor = [UIColor blackColor];
    [self.view addSubview:self.panBtn];
}


-(void)panAction
{
[self.myTextView becomeFirstResponder];
}




- (void)viewDidLoad {
    [super viewDidLoad];
    //键盘将要出来
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyBoardShow:) name:UIKeyboardWillShowNotification object:nil];
    //键盘将要消失
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyBoardHide:) name:UIKeyboardWillHideNotification object:nil];
    [self creatTopView];
    self.inter = 0;
    self.isEdit = NO;
    
    NSDictionary *dic = @{@"auth":[[NSUserDefaults standardUserDefaults]objectForKey:@"auth"],@"client":@"1",@"contentid":self.uid,@"deviceid":@"6D4DD967-5EB2-40E2-A202-37E64F3BEA31",@"limit":[NSString stringWithFormat:@"%ld",self.flag],@"start":@"0",@"version":@"3.0.6"};
    NSLog(@"%@",self.uid);
    [RequestManager requestWithUrlString:KPinglunURL parDic:dic requestType:RequestPOST finish:^(NSData *data) {
        NSDictionary *dic1 = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        self.arr = [pinglunModel arr:dic1];
        [self.tab reloadData];
    } error:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    [self.view addSubview:self.btn];
    [self creatTableView];
    self.titleLabel.text = @"评论";
    [self.view addSubview:self.myTextView];
    // Do any additional setup after loading the view.
}

-(void)creatTableView
{
    self.tab = [[UITableView alloc]initWithFrame:CGRectMake(0, 60, kScreenWidth, kScreenHeight - 60) style:(UITableViewStylePlain)];
    self.tab.delegate = self;
    self.tab.dataSource = self;
    self.tab.rowHeight = 200;
    [self.view addSubview:self.tab];
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    pinglunTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ss"];
    if (!cell) {
        cell = [[pinglunTableViewCell alloc]initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:@"ss"];
    }
    pinglunModel *model = self.arr[indexPath.row];
    [cell creatCell:model];
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arr.count;
    
}

//键盘出现
-(void)keyBoardShow:(NSNotification *)note
{
    //UIKeyboardAnimationDurationUserInfoKey 动画时间
    //UIKeyboardFrameEndUserInfoKey 键盘出现后的位置
    //note.userInfo[UIKeyboardAnimationDurationUserInfoKey];
    CGRect newRect = [note.userInfo[UIKeyboardFrameEndUserInfoKey]CGRectValue];
    [UIView animateWithDuration:[note.userInfo [UIKeyboardAnimationDurationUserInfoKey]floatValue] animations:^{
        self.myTextView.transform = CGAffineTransformMakeTranslation(0, -newRect.size.height - self.myTextView.height);
    }];
    NSLog(@"键盘出来了");
    NSLog(@"%@",note);
}

//键盘消失
-(void)keyBoardHide:(NSNotification *)note
{
    [UIView animateWithDuration:[note.userInfo[UIKeyboardAnimationDurationUserInfoKey]floatValue] animations:^{
        self.myTextView.transform = CGAffineTransformIdentity;
        
    } completion:^(BOOL finished) {
        self.myTextView.text = @"";
    }];
    
    
    
}

#pragma mark---textViewDelegate
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        //上传
        [self uploadComment];
        return NO;
    }
    return YES;
}



#pragma mark --- 提交评论
-(void)uploadComment
{
    NSDictionary *dic1 = @{@"auth":[[NSUserDefaults standardUserDefaults]objectForKey:@"auth"],@"client":@"1",@"content":self.myTextView.text,@"contentid":self.uid,@"deviceid":@"6D4DD967-5EB2-40E2-A202-37E64F3BEA31"};
    [RequestManager requestWithUrlString:KaddCommentURL parDic:dic1 requestType:RequestPOST finish:^(NSData *data) {
        NSDictionary *dic2 = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tab.mj_header beginRefreshing];
        });
        NSLog(@"****************%@",dic2);
    } error:^(NSError *error) {
    }];
    NSDictionary *dic = @{@"auth":[[NSUserDefaults standardUserDefaults]objectForKey:@"auth"],@"client":@"1",@"contentid":self.uid,@"deviceid":@"6D4DD967-5EB2-40E2-A202-37E64F3BEA31",@"limit":[NSString stringWithFormat:@"%ld",self.flag],@"start":@"0",@"version":@"3.0.6"};
    NSLog(@"%@",self.uid);
    [RequestManager requestWithUrlString:KPinglunURL parDic:dic requestType:RequestPOST finish:^(NSData *data) {
        NSDictionary *dic1 = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        self.arr = [pinglunModel arr:dic1];
        [self.tab reloadData];
    } error:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.myTextView resignFirstResponder];
}


-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        pinglunModel *model = self.arr[indexPath.row];
        if (model.isdel) {
            //删数据
            [self.arr removeObjectAtIndex:indexPath.row];
            //删cell
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationLeft];
            [self deleteComment:model];
        }
        [self.tab reloadData];
        NSLog(@"删!");
    }
}


#pragma mark --- 删除数据
-(void)deleteComment:(pinglunModel *)model
{
    //auth
    NSDictionary *dic = @{@"auth":[[NSUserDefaults standardUserDefaults]objectForKey:@"auth"],@"client":@"1",@"commentid":model.contentid,@"contentid":self.uid,@"deviceid":@"6D4DD967-5EB2-40E2-A202-37E64F3BEA31"};
    [RequestManager requestWithUrlString:KdeleteCommentURL parDic:dic requestType:RequestPOST finish:^(NSData *data) {
        NSDictionary *dic1 = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSLog(@"%@",dic1);
    } error:^(NSError *error) {
        
    }];
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
